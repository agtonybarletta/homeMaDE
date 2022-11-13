#!/bin/bash

sudo pacman -Sy awesome konsole feh

#xfconf-query -c xfce4-session -p /sessions/Failsafe/Client0_Command -t string -sa xfce4-panel 
#xfconf-query -c xfce4-session -p /sessions/Failsafe/Client1_Command -t string -sa xfsettingsd
#xfconf-query -c xfce4-session -p /sessions/Failsafe/Client2_Command -t string -sa ""
# disable xfdesktop
#xfconf-query -c xfce4-session -p /sessions/Failsafe/Client4_Command -t string -sa ""

sed -i '1iawesome &' ~/.xinitrc

mkdir -p ~/.config/awesome

cp ./config/awesome/rc.lua ~/.config/awesome/
