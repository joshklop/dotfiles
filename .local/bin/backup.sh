#!/bin/sh

PREFIX='\033['
WHITE="${PREFIX}1;37m"
GREEN="${PREFIX}1;32m"
RESET="${PREFIX}0m"

bwbackup.sh && borgbackup.sh && cd /etc && sudo git push && cd -

echo
echo -e "${GREEN}* ${WHITE}Make sure you umount!${RESET}"
