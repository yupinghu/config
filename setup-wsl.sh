#!/usr/bin/env bash

username=`whoami`
windows_username=`whoami`

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

# Clone the various solarized repos that I use.
function get_solarized() {
  clone https://github.com/seebi/dircolors-solarized.git solarized.directory "ln -fs $HOME/config/solarized.directory/dircolors.256dark $HOME/.dircolors"
}

# Link dotfiles from config directory into $HOME.
function link_dotfiles() {
  ln -fs ~/config/gitconfig ~/.gitconfig
  ln -fs ~/config/vimrc ~/.vimrc
  # Symlink atom config
  powershell.exe Start-Process -Verb RunAs -FilePath "cmd" -ArgumentList "/c","mklink","/D","c:\\Users\\$windows_username\\.atom","c:\\home\\$username\\config\\atom.config"
}

# Make ~/tmp
function make_tmp() {
  mkdir -p /mnt/c/home/$username/tmp
  ln -fs /mnt/c/home/$username/tmp ~/tmp
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

# If there's an argument, treat it as the windows username, needed when linking dotfiles.
if [ ! -z $1 ]; then
  windows_username=$1
fi

sudo apt update
sudo apt upgrade
sudo apt install git
sudo apt install ripgrep

# Setup ssh keys
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -C "yu.ping.hu@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
fi

printf "Add your ssh key to github (https://github.com/settings/keys):\n\n" &&
cat ~/.ssh/id_rsa.pub &&
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
get_solarized
link_dotfiles
make_tmp
gitconfig

popd > /dev/null

# Install rclone
curl https://rclone.org/install.sh | sudo bash

exit 0
