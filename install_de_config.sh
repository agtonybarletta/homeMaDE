#!/bin/bash

# install xfce

sudo pacman -Sy xfce4 xfce4-goodies

cp ./.xinitrc ~/

sudo pacman -Sy chromium pulseaudio libcanberra pavucontrol network-manager-applet xdg-user-dirs noto-fonts-emoji neofetch

cp -r ./config/xfce4 ~/.config

# install awesomeWM

sudo pacman -Sy awesome feh

# sed -i '1iawesome &' ~/.xinitrc

mkdir -p ~/.config/awesome


cp ./config/awesome/* ~/.config/awesome/

# install konsole

sudo pacman -Sy konsole 

cp -r ./config/konsolerc ~/.config
