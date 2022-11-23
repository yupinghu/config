#!/usr/bin/env bash

username=`whoami`

# Clone a git repository if it's not already present, and if it cloned run a command.
function clone() {
  if [ ! -d $2 ]; then
    git clone $1 $2
    eval $3
  fi
}

# Add env.sh to dotfiles.
function add_env() {
  if ! grep -q "# $username config" ~/.bashrc ; then
    printf '\n# %s config\n. ~/config/env.sh\numask 022\n' $username >> ~/.bashrc
  fi
}

# Link dotfiles from config directory into $HOME.
function link_dotfiles() {
  ln -fs ~/config/gitconfig ~/.gitconfig
  ln -fs ~/config/vimrc ~/.vimrc
  ln -fs ~/config/dircolors ~/.dircolors
}

# Make ~/DIR
function make_dir() {
  mkdir -p /mnt/c/home/$username/$1
  ln -fs /mnt/c/home/$username/$1 ~/$1
}

# Setup various gitconfigurations
function gitconfig() {
  # Set my personal email address in this repository.
  git config user.email yu.ping.hu@gmail.com

  # Setup .gitconfig-more
  printf '[user]\n    email = yu.ping.hu@gmail.com\n' > ~/.gitconfig-more
  printf '[core]\n    autocrlf = true\n' >> ~/.gitconfig-more
}

## MAIN SCRIPT

sudo apt update
sudo apt upgrade
sudo apt install git
sudo apt install ripgrep

# Setup ssh keys
if [ ! -f ~/.ssh/id_ed25519.pub ]; then
  ssh-keygen -t ed25519 -C "yu.ping.hu@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
fi

printf "Add your ssh key to github (https://github.com/settings/keys):\n\n" &&
cat ~/.ssh/id_ed25519.pub &&
echo "" &&
read -p "Press enter to continue..."

# Setup "home" directory in Windows.
mkdir -p /mnt/c/home/$username
pushd /mnt/c/home/$username > /dev/null

clone git@github.com:yupinghu/config.git config

# Setup the links from Linux home directory into /mnt/c.
cd ~
mkdir -p /mnt/c/home/downloads
ln -fs /mnt/c/home/downloads
ln -fs /mnt/c/home/$username winhome
ln -fs winhome/config

cd config

add_env
link_dotfiles
make_dir tmp
make_dir bin
gitconfig

popd > /dev/null

# Install rclone
curl https://rclone.org/install.sh | sudo bash

exit 0
