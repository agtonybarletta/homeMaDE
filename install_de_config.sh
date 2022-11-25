#!/bin/bash

# install xfce

sudo pacman --noconfirm -Sy xfce4 xfce4-goodies

cp ./.xinitrc ~/

sudo pacman --noconfirm -Sy chromium pulseaudio libcanberra pavucontrol network-manager-applet xdg-user-dirs noto-fonts-emoji neofetch ntfs-3g thunar-volman pass xclip

cp -r ./config/xfce4 ~/.config

## quick note: here is what to move from ~/.config/xfce to ./config/xfce (with relative path)
# - xsettings.xml (contain fonts + themes etc)
#

# install awesomeWM

sudo pacman --noconfirm -Sy awesome feh xdotool

# sed -i '1iawesome &' ~/.xinitrc

mkdir -p ~/.config/awesome

cp ./config/awesome/* ~/.config/awesome/

# install usefull app
sudo pacman --noconfirm -Sy konsole gnome-clocks
cp -r ./config/konsolerc ~/.config
cp -r ./config/konsole ~/.local/share/

cp -r ./config/gtk-3.0 ~/.config
