#!/bin/sh

sudo pacman -Rns $(pacman -Qtdq)  # Remove orphaned packages
sudo pacman -Syu --needed
paru -Syu --aur --needed -c
pacman -Qqen > $HOME/.pkglist.txt
pacman -Qqem > $HOME/.foreignpkglist.txt
pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)
pip install --upgrade $(pip list --outdated --format=freeze | cut -f 1 -d =)
