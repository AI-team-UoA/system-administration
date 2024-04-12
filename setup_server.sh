#!/bin/bash
# Goal: 
#	Automate server setup
# Requirements: 
#	Ubuntu 22.04
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

# Setup ssh
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
## SSH banner
echo "Do you want to setup an SSH banner? (y/n): "
read answer
if [ "$answer" = "y" ]; then
  echo "Time to add a banner!"
  echo "Press Enter to continue..."
  read enter_key
  sudo nano /etc/ssh/my_banner
  echo "Edit the SSH config file to include: 'Banner /etc/ssh/my_banner'"
  echo "Press Enter to continue..."
  read enter_key
  sudo nano /etc/ssh/sshd_config
  sudo systemctl reload ssh.service
fi

# Setup conda
wget https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh
sudo chmod +x Miniconda3-py310_23.3.1-0-Linux-x86_64.sh
sudo bash Miniconda3-py310_23.3.1-0-Linux-x86_64.sh
rm Miniconda3-py310_23.3.1-0-Linux-x86_64.sh
## Conda permissions
sudo addgroup condagroup
sudo chgrp -R condagroup /home/conda/miniconda3
sudo chmod 770 -R /home/conda/miniconda3
## Conda permissions cron
echo "Ensure that the file exists: /home/pyravlos/system-administration/conda_permissions.sh"
echo "Press Enter to continue..."
read enter_key
cron_job="0 * * * * root /home/pyravlos/system-administration/conda_permissions.sh"
echo "$cron_job" | sudo tee -a /etc/crontab >/dev/null

# Setup docker
sudo apt update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null	
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
## Docker permissions
sudo cp ./permissions /etc/sudoers.d/permissions
