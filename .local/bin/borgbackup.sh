#!/bin/sh

PREFIX='\033['
GREEN="${PREFIX}1;32m"
RESET="${PREFIX}0m"
BOLD=$(tput bold)

mounted='n'
while [[ $mounted =~ [^yY] ]]; do
  echo -e -n "${GREEN}==>${RESET} ${BOLD}Is your flash drive mounted?${RESET} [y/n] "; read resp
  mounted=$resp
done

export BORG_REPO="/mnt/backup"

export BORG_PASSCOMMAND="gpg --decrypt $HOME/.local/bin/passphrase.txt.gpg"

borg create                                      \
        --stats --progress $2 $1                 \
        -e 'sh:**/.*'                            \
        -e 'sh:**/*.iso'                         \
        -e 'sh:**/*.db'                          \
        -e 'sh:**/*.tar'                         \
        -e 'sh:**/*.tar.gz'                      \
        -e 'sh:**/*.tgz'                         \
        -e 'sh:**/*.zip'                         \
        -e '*/downloads'                         \
        -e '*/README.md'                         \
        -e '*/LICENSE'                           \
        -e '*/repos'                             \
        -e '*/Zotero'                            \
        ::"$HOSTNAME--$(date +%+4Y-%m-%d)"       \
        "$HOME"

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix "$HOSTNAME"            \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [[ ${global_exit} -eq 0 ]]; then
        info "Backup and Prune finished successfully"
elif [[ ${global_exit} -eq 1 ]]; then
        info "Backup and/or Prune finished with warnings"
else
        info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}
