#!/usr/bin/env bash

# Make a directory in c:\data and symlink it here.
function make_dir() {
  mkdir -p /mnt/c/$1
  ln -fs /mnt/c/$1 ~/$1
}

## MAIN SCRIPT

# Install Ubuntu software that I like.
sudo apt update
sudo apt upgrade
sudo apt install git
sudo apt install ripgrep
sudo apt install zsh
curl https://rclone.org/install.sh | sudo bash

chsh -s `which zsh`

# Set up various directories
mkdir -p ~/bin
make_dir data
make_dir downloads
mkdir -p ~/mnt/d
mkdir -p ~/tmp

# Perform common setup.
wget https://raw.githubusercontent.com/yupinghu/config/master/setup-common.sh -O ~/tmp/setup-common.sh
~/tmp/setup-common.sh
rm ~/tmp/setup-common.sh

ln -fs ~/config/dircolors ~/.dircolors
