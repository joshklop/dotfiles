#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export HISTCONTROL="ignoreboth:erasedups" 
export GIT_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

if [ -e /home/user/.nix-profile/etc/profile.d/nix.sh ]; then . /home/user/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "/home/user/.starkli/env"
