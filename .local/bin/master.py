#!/usr/bin/env python

import subprocess
import inspect
import os
import sys
import signal


def ready(prompt, fn):
    while True:
        resp = input('==> ' + prompt + ' [y/n] ')
        if resp in 'yY':
            print('running ' + prompt)
            try:
                fn()
            except subprocess.CalledProcessError as e:
                print(prompt + ': ' + str(e))
            break
        elif resp in 'nN':
            print('skipping ' + prompt)
            break


def run(cmd, env=None):
    return subprocess.run(cmd, shell=True, check=True, env=env)


def rank_mirrors():
    run('sudo reflector --country us --age 12 --protocol https --sort '
        'rate --save /etc/pacman.d/mirrorlist')


def update_zinit_and_plugins():
    home = os.getenv('HOME')
    run(f'source {home}/.local/share/zinit/zinit.git/zinit.zsh '
        '&& zinit self-update && zinit update --parallel')


def backup_bw():
    home = os.getenv('HOME')
    run('bw export --format encrypted_json --output '
        f'{home}/documents/bw/bw.json')


def backup_home():
    home = os.getenv('HOME')
    env = os.environ.copy()
    env['BORG_REPO'] = '/mnt/backup'
    pass_file = f'{home}/.local/bin/passphrase.txt.gpg'
    env['BORG_PASSCOMMAND'] = f'gpg --decrypt {pass_file}'

    ignore_patterns = [
        'sh:**/.*',
        'sh:**/*.iso',
        'sh:**/*.db',
        'sh:**/*.tar',
        'sh:**/*.tar.gz',
        'sh:**/*.tgz',
        'sh:**/*.zip',
        '*/downloads',
        '*/Downloads',
        '*/go',
        '*/sdk',
        '*/sd',
        '*/README.md',
        '*/todo.md',
        '*/repos',
        '*/Zotero',
        '*/nextcloud',
        '*/snap',
        '*/documents/zoom',
    ]

    hostname = 'localhost'  # Hardcoded for now.
    borg_create = 'borg create --stats'
    for pattern in ignore_patterns:
        borg_create = f'{borg_create} -e \'{pattern}\''
    borg_create = borg_create + f' ::{hostname}--$(date +%+4Y-%m-%d) {home}'
    run(borg_create, env=env)

    run(f'borg prune --list --glob-archives \'{hostname}-*\' --show-rc '
        '--keep-daily 7 --keep-weekly 4 --keep-monthly 6', env=env)


def backup_etc():
    run('cd /etc && sudo git push && cd -')


def update_nvim():
    # Can't update plugins in headless mode yet.
    # https://github.com/wbthomason/packer.nvim/issues/198
    # So we need to quit manually :(
    run("nvim -c \'lua require(\"me.utils\").update()\'")


def update_system():
    run('paru')
    run('pacmanfile dump')


def sigint_handler(num, frame):
    print('exiting...')
    exit(1)


if __name__ == '__main__':
    signal.signal(signal.SIGINT, sigint_handler)

    special_fns = ['ready', 'run', 'sigint_handler']
    functions = [(name, obj) for name, obj
                 in inspect.getmembers(sys.modules[__name__])
                 if inspect.isfunction(obj) and name not in special_fns]
    for name, fn in functions:
        ready(name.replace('_', ' '), fn)
