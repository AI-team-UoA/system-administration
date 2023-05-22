#!/bin/bash
if [ "$1" = "-h" ]; then 
	echo -e "A utility for adding new users.\n"
	echo "Add a normal user:"
	echo -e "\tpyravlos_adduser USERNAME"
	echo "Add a user with root privileges:"
	echo -e "\tpyravlos_adduser USERNAME -s"
	exit 0
fi 	

if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    >&2 echo "Error: Illegal number of parameters. Run: pyravlos_adduser -h"
    exit 1
fi

sudo adduser "$1"
sudo adduser "$1" condagroup
sudo adduser "$1" docker


if [ "$2" = "-s" ]; then 
	sudo usermod -aG sudo "$1"
fi 	

# setup zsh
sudo cp ~/.zshrc /home/"$1"/.zshrc
sudo chown "$1" /home/"$1"/.zshrc
sudo chsh -s /bin/zsh "$1"
