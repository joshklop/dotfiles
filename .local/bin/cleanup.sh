#!/bin/sh

pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)
trizen -Syu --aur --noconfirm --needed -c
sudo pacman -Syu --needed
sudo pacman -Qqen > $HOME/.pkglist.txt
sudo pacman -Qqem > $HOME/.foreignpkglist.txt
pip list > $HOME/.python_pkglist.txt
