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

function embellished-ready() {
    ready "${GREEN}==>${RESET}${BOLD} $1${RESET}" $2
}

embellished-ready 'Have you deleted unnecessary files?'

# TODO nohup + & may be useful for blindly running this in the background to speed things up
embellished-ready 'Rank mirrors?' 'sudo reflector --country us --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

embellished-ready 'Update packages?' 'sudo pacman -Syu; paru -Syu --aur; pacmanfile dump'

embellished-ready 'Update neovim plugins and treesitter parsers?' 'nvim -c PackerSync; sudo nvim -c PackerSync'

embellished-ready 'Update zinit and plugins?' 'source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" && zinit self-update && zinit update --parallel'

embellished-ready 'Backup bitwarden?' bwbackup.sh

embellished-ready "Backup ${HOME}?" borgbackup.sh

embellished-ready 'Backup /etc?' 'cd /etc && sudo git push && cd -'

echo
echo -e "${GREEN}* ${BOLD}Make sure you umount!${RESET}"
echo

embellished-ready 'Commit and push your dotfiles.'
