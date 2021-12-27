#!/bin/sh

sudo pacman -Syu
paru -Syu --aur
pacmanfile sync
python3 -m pip install --upgrade pip
nvim -c PackerUpdate
sudo nvim -c PackerUpdate
