#!/bin/bash

program_name="install_de_config.sh"
program_desc="Installation script for basic Desktop Environment (xfce+awesome) configuration. In copy configuration files for xfce, awesomeWM and Konsole"
#    Copyright (C) 2020 A.G. Tony Barletta
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version. 
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details. 
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

verbose=0
silent=0
logfile=output.log

usage(){
	cat <<END_USAGE
	usage: 
	  ./$program_name.sh [-v|--verbose] [-s|--silent] [-h|--help]

	options:
	  -v --verbose 					turn on verbose output
	  -s --silent 					turn off all output
	  -h --help 					show help
	  -l --logfile 					set log file [default: $logfile]
END_USAGE
}
help(){
	cat <<END_HELP
	$program_name 
	$program_desc
	Copyright (C) 2020 A.G. Tony Barletta
	This program comes with ABSOLUTELY NO WARRANTY; 
	This is free software, and you are welcome to redistribute it
	under certain conditions;
END_HELP
	usage
}



msgv(){
	[ $verbose == 1 ] && echo $*
}

msg(){
	[ $silent != 1 ] && echo $*
}
msge(){
	>&2 echo $*
}

check_output(){
	if [ "$1" -le "-1" ]; then
		msge got status code $1
		msge exiting
	fi
	return $1
}

while [[ $# -gt 0 ]]; do
	opt=$1
	value=$2
    case $opt in
		-h|--help)
			help
			exit 0
			;;
		-v|--verbose)
			verbose=1
			shift 1
			;;
		-s|--silent)
			silent=1
			shift 1
			;;
		-l|--logfile)
			logfile=$value
			shift 2
			;;
		*)
			msg Unknow argument $opt
			usage
			exit 1
			;;
	esac
done



msgv 	argument passed:
msgv 	verbose: $verbose
msgv 	silent: $silent
msgv 	logfile: $logfile

#	     _             _   
#	 ___| |_ __ _ _ __| |_ 
#	/ __| __/ _` | '__| __|
#	\__ \ || (_| | |  | |_ 
#	|___/\__\__,_|_|   \__|


msg installing xfce4 
sudo pacman --noconfirm -Sy xfce4 xfce4-goodies >> $logfile
check_output $? || exit -1



msg setting .xinitrc

cp ./.xinitrc ~/
check_output $? || exit -1


pkill xfconfd
rm -rf /home/$USER/.cache/*
msg coping xfce4 config files

cp -r ./config/xfce4 ~/.config
check_output $? || exit -1
cp -r ./config/user-dirs.dirs ~/.config
check_output $? || exit -1



msg installing awesomeWM and its utils

sudo pacman --noconfirm -Sy awesome feh xdotool picom >> $logfile
check_output $? || exit -1



msg installing awesomeWM config files

mkdir -p ~/.config/awesome
check_output $? || exit -1
cp ./config/awesome/* ~/.config/awesome/
check_output $? || exit -1



msg installing DE utils

sudo pacman --noconfirm -Sy chromium pulseaudio libcanberra pavucontrol \
	network-manager-applet xdg-user-dirs noto-fonts-emoji ntfs-3g   \
	thunar-volman gvfs pass xclip pulseaudio-bluetooth bluez blueman \
	konsole gnome-clocks >> $logfile
check_output $? || exit -1



msg copying konsole configs

cp -r ./config/konsolerc ~/.config
check_output $? || exit -1
cp -r ./config/konsole ~/.local/share/
check_output $? || exit -1

msg DE configs installed!
