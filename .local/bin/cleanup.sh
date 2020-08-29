#!/bin/sh

pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)
sudo pacman -Syu
trizen -Syu --aur --noconfirm
sudo pacman -Qqen > $HOME/.pkglist.txt
sudo pacman -Qqem > $HOME/.foreignpkglist.txt
pip list > $HOME/.python_pkglist.txt
