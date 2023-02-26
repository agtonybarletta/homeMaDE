#!/bin/bash

#!/bin/bash

program_name="install_basic.sh"
program_desc="Install script for basic gnu/linux packages such as command line tools (htop, wget, curl), vi/vim editor and build tools. It also install user repository tools (yay) "
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
logfile="output.log"

usage(){
	cat <<END_USAGE
	usage: 
	  ./$program_name.sh [-v|--verbose] [-s|--silent] [-h|--help] [-l|--logfile <logfilename>]


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


msg --------------------------
msg starting installing basic
msg --------------------------

# install basics 
# bind: nslookup
sudo pacman --noconfirm -Sy git vi vim man base-devel tree htop curl wget neofetch unzip unrar bind >> $logfile
check_output $? || exit -1

msg installed packages

msg --------------------------
msg installing yay
msg --------------------------

# install yay
git clone --quiet https://aur.archlinux.org/yay.git ~/yay >> $logfile
check_output $? || exit -1
old=$(pwd)
cd ~/yay
makepkg -si --noprogressbar --noconfirm	 >> $logfile 
check_output $? || exit -1
rm -rf yay
check_output $? || exit -1
cd $old
msg yay installed
