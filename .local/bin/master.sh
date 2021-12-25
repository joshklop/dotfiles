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
      echo -e -n "$prompt [y/n] $RESET"; read resp
      if [[ $resp =~ y ]]; then
        $cmd
        break
      elif [[ $resp =~ n ]]; then
        echo -e "${RED}Skipping...${RESET}"
        break
      fi
    fi
  done
}

ready "${GREEN}==>${RESET} ${BOLD}Have you deleted unnecessary files?${RESET}" 
ready "${GREEN}==>${RESET} ${BOLD}Update packages and neovim plugins?${RESET}" cleanup.sh
ready "${GREEN}==>${RESET} ${BOLD}Backup bitwarden?${RESET}" bwbackup.sh
ready "${GREEN}==>${RESET} ${BOLD}Backup ${HOME}?${RESET}" borgbackup.sh
ready "${GREEN}==>${RESET} ${BOLD}Backup /etc?${RESET}" "sudo etcbackup.sh"
echo
echo -e "${GREEN}* ${BOLD}Make sure you umount!${RESET}"
echo
ready "${GREEN}==>${RESET} ${BOLD}Commit and push your dotfiles.${RESET}"
