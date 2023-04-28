#!/usr/bin/env bash

username=`whoami`
email="yu.ping.hu@gmail.com"

if [ -n $1 ]; then
  email=$1
fi

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
  gnome-tweaks
  gnome-shell-extensions
  chrome-gnome-shell
  fonts-hack
  fonts-roboto
)
sudo apt install "${install_list[@]}"

printf "\n*** Switch to zsh ***\n"
chsh -s `which zsh`

printf "\n*** Generate SSH key ***\n"
if [ ! -f ~/.ssh/id_ed25519.pub ]; then
  ssh-keygen -t ed25519 -C "yu.ping.hu@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi

printf "\n*** Open github in chrome so you can add your SSH key ***\n"
cat ~/.ssh/id_rsa.pub
google-chrome https://github.com/settings/keys

printf "\n*** Press enter after you've added your key to github... ***\n"
read

if [ ! -d ~/config ]; then
  git clone git@github.com:yupinghu/config.git
  printf '[user]\n    email = %s\n' $email >> ~/config/.git/config
fi

printf "\n*** Setting up directories, dotfiles, and symlinks ***\n"

mkdir -p ~/bin
mkdir -p ~/downloads
mkdir -p ~/tmp

printf '[user]\n    email = %s\n[core]\n    autocrlf = input\n' $email > ~/.gitconfig-more
if ! grep -q "# $username config" ~/.bashrc ; then
  printf '\n# %s config\n. ~/config/env.sh\numask 022\n' $username >> ~/.bashrc
fi
if ! grep -q "# $username config" ~/.zshrc ; then
  printf '\n# %s config\n. ~/config/env.sh\numask 022\n' $username >> ~/.zshrc
fi

ln -fs ~/config/gitconfig ~/.gitconfig
ln -fs ~/config/vimrc ~/.vimrc

# Just here for documentation
# gnome_extensions_list=(
#   Screenshot tool
#   Frippery Move Clock
#   gTile
#   GTK Title Bar
#   Hide Activities Button
#   OpenWeather
#   Sound Input & Output Device Chooser
#   Vitals
#   Removable Drive Menu
#   Ubuntu Dock
# )
