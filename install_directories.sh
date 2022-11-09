#!/bin/bash

link_dir(){
	if [ -d /home/$USER/$1 ];
	then
		echo /home/$USER/$1 already exists;
		return 0
	fi
	while : ; do
		echo "set path for $1"

		read dir

		dir=$(realpath $dir)

		if [ -d $dir ];
		then
			break
		fi	
	done

	echo dir: $dir

	if [ -d $dir ];
	then
		ln -s $dir /home/$USER/$1
	fi

}

echo "installing all directories..."

link_dir "Pictures"
link_dir "Videos"
link_dir "Music"
link_dir "Downloads"
link_dir "Documents"

xdg-user-dirs-update
