#!/bin/bash

program_name="install_projects.sh"
program_desc="install projects from file list"
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
file_list="projects_list.txt"
example_argument_b=0
example_mandatory_positional_argument="default_c"
example_argument_opt=0

usage(){
	cat <<END_USAGE
	usage: 
	  ./$program_name.sh [-v|--verbose] [-s|--silent] [-h|--help] [-l|--file_list projects_list.txt]

	options:
	  -v --verbose 					turn on verbose output
	  -s --silent 					turn off all output
	  -h --help 					show help
	  -l --file_list 				file containing list of git projects to be downloaded
							rows can optionally contain destination folders
							project_list.txt
								git.github.com:user/project1.git
								git.github.com:user/project2.git,/home/user/path/destination/

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
		-l|--file_list)
			example_argument_a=$value
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
msgv 	file_list: $file_list


#	     _             _   
#	 ___| |_ __ _ _ __| |_ 
#	/ __| __/ _` | '__| __|
#	\__ \ || (_| | |  | |_ 
#	|___/\__\__,_|_|   \__|

# check dependencies requirement

if [ ! -x $(command -v ssh) ]; then
	msge ssh not available	
	exit -1
fi
if [ ! -d ~/.ssh  ] || [ ! "$(ls -A ~/.ssh )" ]; then
	msge "no key in ~/.ssh"
	exit -1
fi
if [ ! -x $(command -v git ) ]; then
	msge git not available
	exit -1
fi

# check file list

if [ ! -f $file_list ]; then
	echo "cannot read file $file_list"
	exit -1;
else
	msg using file list: $file_list
fi

for i in $( cat $file_list) ; do
	msgv line: $i
	repository=${i%%,*}
	destination=${i##*,}
	msgv repository $repository
	if [[ ! "$i" =~ ","  ]] || [[ ! $destination ]]; then
		destination=~/projects/
	fi
	msgv destination $destination
	
	msg "cloning $repository in $destination"
	git -C $destination clone $repository

done


