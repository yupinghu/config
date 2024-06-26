#!/usr/bin/env bash

printf "\n*** Install Chrome ***\n"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

printf "\n*** apt ***\n"
sudo apt update
sudo apt upgrade
install_list=(
  git
  ripgrep
  zsh
  vim
  fonts-hack
  fonts-roboto
)
sudo apt install "${install_list[@]}"

printf "\n*** Switch to zsh ***\n"
chsh -s `which zsh`

mkdir -p ~/bin
mkdir -p ~/downloads
mkdir -p ~/tmp

# Get and run the common setup script.
wget https://raw.githubusercontent.com/yupinghu/config/master/setup-common.sh -O ~/tmp/setup-common.sh
~/tmp/setup-common.sh
rm ~/tmp/setup-common.sh
