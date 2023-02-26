#!/bin/bash

program_name="install_theme.sh"
program_desc="Install bild custom themes and install it."
#    Copyright (C) 2022 A.G. Tony Barletta
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
# example_argument_a="default_a"
# example_argument_b=0
# example_mandatory_positional_argument="default_c"
# example_argument_opt=0

usage(){
	cat <<END_USAGE
	usage: 
	  ./$program_name.sh [-v|--verbose] [-s|--silent] [-h|--help] 
		[-l|--logfile <logfilename>] [-a|example_argument_a <value-of-a>]
		[-b <value-of-b>] [-o|--example_argument_opt] <mandatory-positional-argument>

	options:
	  -v --verbose 					turn on verbose output
	  -s --silent 					turn off all output
	  -h --help 					show help
	  -l --logfile 					set log file [default: $logfile]
	  -a --example_argument_a 		a variable with string value
	  -b 							a variable with number value
	  -o --example_argument_opt		a variable with no value
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
	[ $verbose == 1 ] && echo "$*"
}

msg(){
	[ $silent != 1 ] && echo $*
}
msge(){
	>&2 echo $*
}

check_output(){
	if [ "$1" -ne "0" ]; then
		msge got status code $1
		msge exiting
	fi
	return $1
}
# 1 mandatory argument
#if [[ $# -lt 1 ]]; then
#	msge mandatory argument needed
#	usage
#	exit 0
#fi

if [[ ${@: -1} =~ ^-h|--help$ ]] ; then
	help
	exit 0
fi

#example_mandatory_positional_argument=${@: -1}
#remove parsed mandatory arguments
#set -- "${@:1:$#-1}"



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
msgv 	logfile: $logfile
msgv 	example_argument_a: $example_argument_a
msgv 	example_argument_b: $example_argument_b
msgv 	example_argument_opt: $example_argument_opt
msgv 	example_mandatory_positional_argument: $example_mandatory_positional_argument


#	     _             _   
#	 ___| |_ __ _ _ __| |_ 
#	/ __| __/ _` | '__| __|
#	\__ \ || (_| | |  | |_ 
#	|___/\__\__,_|_|   \__|

# msg doing my thing
# msg inital b $example_argument_b
# msg increasing b
# b=$(( $example_argument_b + 1 ))
# example_argument_b=$b
# msg b is $example_argument_b
# msge echoing error
# msg this progam ends here
# msg $example_mandatory_positional_argument
# {
# 	echo this output will be shown in log file
# }>> $logfile

# true
# check_output $? || exit -1
# msg printing this line because check_output worked

while read i ; do
	msg $i
	if [[ "$i" =~ ^\s*(#.*)?$ ]]; then
		msgv ignoring $i
	else
		a=ciao
		IFS="=" read -ra values <<< "$i"
		msgv variable: ${values[0]}
		msgv value: "${values[1]}"
		msgv value parsed: $( eval echo ${values[1]} )
		export "${values[0]}"=$(eval echo ${values[1]})
		msgv exported ${values[0]} with value $(eval echo ${values[1]})
	fi

done < theme/base.properties; 

msgv "$(printenv | grep agtb_theme | grep -v variable_name | sort) "

envsubst < theme/gtk.css > gtk-compiled.css

