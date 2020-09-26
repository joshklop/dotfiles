#!/bin/sh

pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)
sudo pacman -Syu --needed
yay -Syu --aur --needed -c
sudo pacman -Qqen > $HOME/.pkglist.txt
sudo pacman -Qqem > $HOME/.foreignpkglist.txt
pip list > $HOME/.python_pkglist.txt
