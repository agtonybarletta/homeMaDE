#!/bin/bash

# install basics 
sudo pacman --noconfirm -Sy git vi vim man base-devel tree htop curl wget neofetch

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -rf yay
