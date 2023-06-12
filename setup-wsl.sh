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

# Setup ssh keys
if [ ! -f ~/.ssh/id_ed25519.pub ]; then
  ssh-keygen -t ed25519 -C "yu.ping.hu@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi
printf "Add your ssh key to github (https://github.com/settings/keys):\n\n" &&
cat ~/.ssh/id_ed25519.pub &&
echo "" &&
read -p "Press enter to continue..."

# Get my config repository and link dotfiles.
if [ ! -d ~/config ]; then
  pushd ~ >> /dev/null
  git clone git@github.com:yupinghu/config.git
  # Set my personal email address in the config repository.
  cd config
  git config user.email yu.ping.hu@gmail.com
  popd >> /dev/null
  printf '[include]\n    path = ~/config/gitconfig\n' >> ~/.gitconfig
fi
ln -fs ~/config/vimrc ~/.vimrc
ln -fs ~/config/dircolors ~/.dircolors

# Set up various directories
mkdir -p ~/bin
make_dir data
make_dir downloads
mkdir -p ~/mnt/d
mkdir -p ~/tmp

# Add env.sh to dotfiles.
username=`whoami`
if ! grep -q "# $username config" ~/.zshrc ; then
  printf '\n# %s config\n. ~/config/env.sh\numask 022\n' $username >> ~/.zshrc
fi
