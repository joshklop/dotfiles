#!/bin/sh

sudo pacman -Syu
paru -Syu --aur
pacman -Qqen > $HOME/.pkglist.txt
pacman -Qqem > $HOME/.foreignpkglist.txt
pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)
