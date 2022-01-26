#!/bin/sh

sudo pacman -Syu
paru -Syu --aur
pacmanfile dump

python3 -m pip install --upgrade pip

nvim -c PackerUpdate
sudo nvim -c PackerUpdate

zinit self-update
zinit update --parallel
