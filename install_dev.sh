#!/bin/bash

program_name="install_dev.sh"
program_desc="developer tools installers"
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
		-a|--example_argument_a)
			example_argument_a=$value
			shift 2
			;;
		-b)
			example_argument_b=$value
			shift 2
			;;
		-o|--example_argument_opt)
			example_argument_opt=1
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

# installing git, vi, vim, neovim, nano

msg Installing basic tools

sudo pacman --noconfirm -Sy git vi vim neovim nano code

# installing c, cpp

msg Installing c/cpp tools

sudo pacman --noconfirm -Sy gcc g++ make clang clang++

# install node

msg nodejs tools

yay -S nvm

echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc

source /usr/share/nvm/init-nvm.sh

nvm install 18

nvm use 18

sudo pacman --noconfirm -Sy npm

# install java

msg java tools

sudo pacman --noconfirm -Sy jre-openjdk jdk-openjdk openjdk-doc

# install python

msg python tools

sudo pacman --noconfirm -Sy python python-pip pip python-virtualenv

# install lua

msg lua tools

sudo pacman --noconfirm -Sy lua luajit

# installing IDEs

msg installing IDEs

sudo pacman --noconfirm -Sy code $ eclipse-jee
# yay -S intellij-idea-community-edition

# install other

msg installing others

# sudo pacman -Sy docker dbeaver mariadb mysql
# yay -S postaman-bin 


