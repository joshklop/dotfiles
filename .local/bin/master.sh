#!/bin/sh

PREFIX='\033['
GREEN="${PREFIX}1;32m"
RED="${PREFIX}0;31m"
RESET="${PREFIX}0m"
BOLD=$(tput bold)

function ready(){
  prompt=$1
  cmd=$2
  while true; do
    if [[ $cmd == "" ]]; then
      echo -e -n "$prompt [y/n] $RESET"; read resp
      [[ $resp =~ [yY] ]] && break
    else
      echo -e -n "$prompt [y/s/n] $RESET"; read resp
      if [[ $resp =~ y ]]; then
        $cmd
        break
      elif [[ $resp =~ s ]]; then
        echo -e "${RED}Skipping...${RESET}"
        break
      fi
    fi
  done
}

ready "${GREEN}==>${RESET} ${BOLD}Have you deleted unnecessary files?${RESET}" 
git_unsaved_changes.sh
ready "${GREEN}==>${RESET} ${BOLD}Are you prepared to continue to cleanup.sh?${RESET}" cleanup.sh
ready "${GREEN}==>${RESET} ${BOLD}Are you prepared to continue to bwbackup.sh?${RESET}" bwbackup.sh
ready "${GREEN}==>${RESET} ${BOLD}Are you prepared to continue to borgbackup.sh?${RESET}" borgbackup.sh
ready "${GREEN}==>${RESET} ${BOLD}Are you prepared to continue to backup /etc?${RESET}" "sudo etcbackup.sh"
echo
echo -e "${GREEN}* ${BOLD}Make sure you umount!${RESET}"
echo
ready "${GREEN}==>${RESET} ${BOLD}Now commit and push your dotfiles. Continue when you are ready.${RESET}"

echo
echo -e "${GREEN}* ${BOLD}All done! Make sure you reboot!${RESET}"
