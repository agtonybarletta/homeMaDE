#!/bin/bash

program_name="install_de_config.sh"
program_desc="Installation script for basic Desktop Environment (xfce+awesome) configuration"
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

usage(){
	cat <<END_USAGE
	usage: 
	  ./$program_name.sh [-v|--verbose] [-s|--silent] [-h|--help]

	options:
	  -v --verbose 					turn on verbose output
	  -s --silent 					turn off all output
	  -h --help 					show help
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

stdout=&1

stderr=&2

if [ $silent == 1 ] ; then stdout=/dev/null; stderr=/dev/null; fi

#	     _             _   
#	 ___| |_ __ _ _ __| |_ 
#	/ __| __/ _` | '__| __|
#	\__ \ || (_| | |  | |_ 
#	|___/\__\__,_|_|   \__|

{
	# install xfce

	sudo pacman --noconfirm -Sy xfce4 xfce4-goodies

	cp ./.xinitrc ~/

	sudo pacman --noconfirm -Sy chromium pulseaudio libcanberra pavucontrol network-manager-applet xdg-user-dirs noto-fonts-emoji ntfs-3g thunar-volman gvfs pass xclip pulseaudio-bluetooth bluez blueman 

	cp -r ./config/xfce4 ~/.config

	cp -r ./config/user-dirs.dirs ~/.config

	## quick note: here is what to move from ~/.config/xfce to ./config/xfce (with relative path)
	# - xsettings.xml (contain fonts + themes etc)
	#

	# install awesomeWM

	sudo pacman --noconfirm -Sy awesome feh xdotool picom

	# sed -i '1iawesome &' ~/.xinitrc

	mkdir -p ~/.config/awesome

	cp ./config/awesome/* ~/.config/awesome/

	# install usefull app
	sudo pacman --noconfirm -Sy konsole gnome-clocks

	cp -r ./config/konsolerc ~/.config
	cp -r ./config/konsole ~/.local/share/

	# cp -r ./config/gtk-3.0 ~/.config


} > $stdout 2> $stderr
