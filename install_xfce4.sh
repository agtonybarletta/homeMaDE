#!/bin/bash

sudo pacman -Sy xfce4 xfce4-goodies

cp ./.xinitrc ~/

sudo pacman -Sy chromium pulseaudio libcanberra pavucontrol network-manager-applet xdg-user-dirs