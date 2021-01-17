#!/bin/sh

pacman -Rns $(pacman -Qtdq)  # Remove orphaned packages
sudo pacman -Syu --needed
paru -Syu --aur --needed -c
sudo pacman -Qqen > $HOME/.pkglist.txt
sudo pacman -Qqem > $HOME/.foreignpkglist.txt
pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)
