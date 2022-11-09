#!/bin/bash

sudo pacman -Sy awesome konsole

xfconf-query -c xfce4-session -p /sessions/Failsafe/Client0_Command -t string -sa awesome
xfconf-query -c xfce4-session -p /sessions/Failsafe/Client4_Command -t string -sa ""

mkdir -p ~/.config/awesome

cp ./config/awesome/rc.lua ~/.config/awesome/
