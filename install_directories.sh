#!/bin/bash

program_name="install_directories.sh"
program_desc="Links xdg directories to directories not in home"
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

ask_input_return=""
ask_input(){

	ask_input_return=""
	if [ -d /home/$USER/$1 ];
	then
		msgv /home/$USER/$1 already exists, skipping;
		return 0
	fi

	msgv "asking input"
	answer=""
	while [[ "$answer" == "" ]]; do
		read -p "Do you want to link /home/$USER/$1 to another place (y/n)?" answer
		case "$answer" in 
		  y|Y )
			  answer=true
			  ;;
		  n|N ) answer=false;;
		  * ) answer="";;
		esac
		msgv $answer
	done

	msgv "answer: $answer"

	if [  $answer ==  false ]; then
		msgv "ask_input returning with value answer $answer"
		return -1;
	fi

	while : ; do

		read -e -p "Enter path for $1:" dir

		dir=$(realpath $dir)

		if [ -d $dir ];
		then
			break
		else
			msg "Please enter a valid path"
		fi
	done
	ask_input_return=$dir
	msgv "ask input returning with $ask_input_return value"


}

link_dir(){

	ask_input $1
	if [ "$ask_input_return" == "" ]; then
		msg "Skipping /home/$USER/$1"
		msg ""
		return 0
	fi
	dir=$ask_input_return

	msg "Linking /home/$USER/$1 to $dir ..."

	if [ -d $dir ];
	then
		ln -s $dir /home/$USER/$1
		[[ $? == 0 ]] && msg "Linked /home/$USER/$1 to $dir" && msg ""
	fi


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


echo "installing all directories..."

link_dir "Pictures"
link_dir "Videos"
link_dir "Music"
link_dir "Downloads"
link_dir "Documents"

xdg-user-dirs-update
