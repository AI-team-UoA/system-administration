#!/bin/bash
if [ "$1" = "-h" ]; then 
	echo -e "A utility for removing users and their home directories.\n"
	echo "Remove a normal user:"
	echo -e "\tpyravlos_deluser USERNAME"
	exit 0
fi 

if [ "$#" -ne 1 ]; then
    >&2 echo "Error: Illegal number of parameters. Use: pyravlos_deluser USERNAME"
    exit 1
fi

sudo userdel "$1"
sudo rm -rf /home/"$1"/
