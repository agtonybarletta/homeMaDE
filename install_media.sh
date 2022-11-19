#!/bin/bash

program_name="install_media.sh"
program_desc="Install all the media tools needed (audio, video, images, 3d modeling)"
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


#	     _             _   
#	 ___| |_ __ _ _ __| |_ 
#	/ __| __/ _` | '__| __|
#	\__ \ || (_| | |  | |_ 
#	|___/\__\__,_|_|   \__|

msg --------------------------
msg installing image tools
msg --------------------------
sudo pacman -Sy imagemagick gimp inkscape rawthreapee darktable

msg --------------------------
msg installing video tools
msg --------------------------
sudo pacman -Sy vlc

msg -------------------------
msg installing music tools
msg --------------------------
sudo pacman -Sy clementine ffmpeg

msg -------------------------
msg install 3d modellin tools
msg --------------------------
sudo pacman -Sy blender freecad prusa-slicer 
yay -Sy printrun


# mkdir -p ~/.local/bin
# wget -O ~/.local/bin/Ultimaker-Cura-5.2.1-linux-modern.AppImage "https://github.com/Ultimaker/Cura/releases/download/5.2.1/Ultimaker-Cura-5.2.1-linux-modern.AppImage"
# chmod +x ~/.local/bin/Ultimaker-Cura-5.2.1-linux-modern.AppImage


