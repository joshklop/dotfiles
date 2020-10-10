#!/bin/sh

PREFIX='\033['
WHITE="${PREFIX}1;37m"
GREEN="${PREFIX}1;32m"
RED="${PREFIX}0;31m"
RESET="${PREFIX}0m"

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
        "$cmd"
        break
      elif [[ $resp =~ s ]]; then
        echo -e "${RED}Skipping...${RESET}"
        break
      fi
    fi
  done
}

ready "${GREEN}==>${RESET} ${WHITE}Have you deleted unnecessary files?" 
git_unsaved_changes.sh
ready "${GREEN}==>${RESET} ${WHITE}Are you prepared to continue to cleanup.sh?" cleanup.sh
ready "${GREEN}==>${RESET} ${WHITE}Are you prepared to continue to backup.sh?" backup.sh

ready "${GREEN}==>${RESET} ${WHITE}Now commit and push your dotfiles. Continue when you are ready."

echo
echo -e "${GREEN}* ${WHITE}All done! Make sure you reboot!${RESET}"
