#!/bin/bash

check_output(){
	if [ "$1" -le "-1" ]; then
		msge got status code $1
		msge exiting
	fi
	return $1
}

./install_basic.sh
check_output $? || exit -1

./install_de_config.sh
check_output $? || exit -1

./install_directories.sh
check_output $? || exit -1

./install_projects.sh
check_output $? || exit -1

./install_dev.sh
check_output $? || exit -1

./install_media.sh
check_output $? || exit -1
