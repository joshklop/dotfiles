#!/usr/bin/env zsh

# TODO this is in need of a full rewrite

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

# https://askubuntu.com/a/1413600
# embellished-ready "Run snap refresh?" refresh
# case $refresh in
#     [Nn]* ) break;;
#     * )
#         sudo snap refresh --list
# 
#         # Update the last-refresh time
#         sudo systemctl stop snapd
#         sudo jq -c ".data[\"last-refresh\"] = \"$(date +%Y-%m-%dT%H:%M:%S%:z)\"" /var/lib/snapd/state.json > /var/lib/snapd/state.json.new
#         sudo chmod 600 /var/lib/snapd/state.json.new
#         sudo mv /var/lib/snapd/state.json.new /var/lib/snapd/state.json
#         sudo systemctl start snapd
# 
#         sudo snap set system refresh.hold="$(date --date='today+90days' --iso-8601=seconds)"
#     ;;
# esac

# TODO: do this in headless mode https://github.com/wbthomason/packer.nvim/issues/1152
embellished-ready 'Update neovim plugins and treesitter parsers?' 'nvim -c PackerSync; sudo nvim -c PackerSync'

embellished-ready 'Update zinit and plugins?' 'source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" && zinit self-update && zinit update --parallel'

function bw-backup () {
    bw export --format ecrypted_json --output "$HOME/documents/bw/bw.json"
}

embellished-ready 'Backup bitwarden?' bw-backup

embellished-ready "Backup ${HOME}?" borgbackup.sh

embellished-ready 'Backup /etc?' 'cd /etc && sudo git push && cd -'

echo
echo -e "${GREEN}* ${BOLD}Make sure you umount!${RESET}"
echo

embellished-ready 'Commit and push your dotfiles.'

