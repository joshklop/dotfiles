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
    # TODO handle CalledProcessError
    # Then we can support better chaining instead of using &&
    return subprocess.run(cmd, shell=True, check=True, env=env)


def update_zinit_and_plugins():
    home = os.getenv('HOME')
    run(f'source {home}/.local/share/zinit/zinit.git/zinit.zsh '
        '&& zinit self-update && zinit update --parallel')


def backup_bw():
    home = os.getenv('HOME')
    run('bw export --format encrypted_json --output '
        f'{home}/documents/bw/bw.json')


def update_nvim():
    run("nvim --headless \'+Lazy! sync\' +qa")
    print("remember to manually update Mason")


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
