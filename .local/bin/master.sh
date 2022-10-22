#!/usr/bin/env zsh

PREFIX='\033['
GREEN="${PREFIX}1;32m"
RED="${PREFIX}0;31m"
RESET="${PREFIX}0m"
BOLD=$(tput bold)

function ready(){
  prompt=$1
  cmd=$2
  while true; do
    if [[ "$cmd" == "" ]]; then
      echo -e -n "$prompt [y/n] $RESET"; read resp
      [[ $resp =~ [yY] ]] && break
    else
      echo -e -n "$prompt [y/n] $RESET"; read resp
      if [[ "$resp" =~ y ]]; then
        zsh -c "$cmd"
        break
      elif [[ "$resp" =~ n ]]; then
        echo -e "${RED}Skipping...${RESET}"
        break
      fi
    fi
  done
}

ready "${GREEN}==>${RESET} ${BOLD}Have you deleted unnecessary files?${RESET}" 

# TODO nohup + & may be useful for blindly running this in the background to speed things up
ready "${GREEN}==>${RESET} ${BOLD}Rank mirrors?${RESET}" 'sudo reflector --country us --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

ready "${GREEN}==>${RESET} ${BOLD}Update packages?${RESET}" 'sudo pacman -Syu; paru -Syu --aur; pacmanfile dump; python3 -m pip install --upgrade pip'

ready "${GREEN}==>${RESET} ${BOLD}Update neovim plugins and treesitter parsers?${RESET}" 'nvim -c PackerUpdate; sudo nvim -c PackerUpdate'

ready "${GREEN}==>${RESET} ${BOLD}Update zinit and plugins?${RESET}" 'source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" && zinit self-update && zinit update --parallel'

ready "${GREEN}==>${RESET} ${BOLD}Backup bitwarden?${RESET}" bwbackup.sh

ready "${GREEN}==>${RESET} ${BOLD}Backup ${HOME}?${RESET}" borgbackup.sh

ready "${GREEN}==>${RESET} ${BOLD}Backup /etc?${RESET}" 'cd /etc && sudo git push && cd -'

echo
echo -e "${GREEN}* ${BOLD}Make sure you umount!${RESET}"
echo

ready "${GREEN}==>${RESET} ${BOLD}Commit and push your dotfiles.${RESET}"
