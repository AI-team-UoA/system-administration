#!/bin/bash
# Goal: 
#	Automate server setup
# Requirements: 
#	Ubuntu 22.04
#	GPU
#	The root user is named 'pyravlos'
#	Good vibes
# Created by:
#	Your beloved system administrator, Sergios - Anestis Kefalidis

# Install the latest updates
sudo apt update
sudo apt dist-upgrade

# Install utilities
sudo apt -y install screenfetch nmap htop iotop nano vim git curl

# Install basic C & C++ libraries and tools
sudo apt -y install build-essential gdb valgrind

# Install Java 8 & 11
sudo apt -y install openjdk-8-jdk
sudo apt -y install openjdk-11-jdk

# Install kernel headers and development libraries
sudo apt -y install linux-headers-$(uname -r)

## Install CUDA
#sudo apt-key del 7fa2af80
#wget https://developer.download.nvidia.com/compute/cuda/repos/2204/x86_64/cuda-keyring_1.0-1_all.deb
#sudo dpkg -i cuda-keyring_1.0-1_all.deb
#sudo apt-get update
#sudo apt-get install cuda

# Setup ssh
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

# Setup conda
wget https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh
sudo chmod +x Miniconda3-py310_23.3.1-0-Linux-x86_64.sh
sudo bash Miniconda3-py310_23.3.1-0-Linux-x86_64.sh
rm Miniconda3-py310_23.3.1-0-Linux-x86_64.sh

sudo addgroup condagroup
sudo chgrp -R condagroup /home/conda/miniconda3
sudo chmod 770 -R /home/conda/miniconda3

# Setup docker
sudo apt update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null	
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo cp ./permissions /etc/sudoers.d/permissions
