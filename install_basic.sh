#!/bin/bash

# install basics 
sudo pacman -S git vi vim man base-devel tree

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -rf yay
