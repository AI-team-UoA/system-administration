#!/bin/bash
sudo apt install -y zsh
cp ./.zshrc ~/.zshrc

# syntax highlighting
sudo apt install -y zsh-syntax-highlighting
sudo cp -r /usr/share/zsh-syntax-highlighting/ /usr/share/zsh/plugins/zsh-syntax-highlighting/

# substring search
sudo git clone https://github.com/zsh-users/zsh-history-substring-search.git /usr/share/zsh/plugins/zsh-history-substring-search

# autosuggestions
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh/plugins/zsh-autosuggestions

# powerlevel10k
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/zsh-theme-powerlevel10k
sudo cp ~/.p10k.zsh /usr/share/zsh/p10k.zsh
