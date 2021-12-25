#!/bin/sh

sudo pacman -Syu
paru -Syu --aur
pacman -Qqen > $HOME/.pkglist.txt
pacman -Qqem > $HOME/.foreignpkglist.txt
python3 -m pip install --upgrade pip
# Don't upgrade global python packages unless you have to
# Prefer virtual environments. Plus, pip takes a while.
# pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)
nvim -c PackerUpdate
sudo nvim -c PackerUpdate
