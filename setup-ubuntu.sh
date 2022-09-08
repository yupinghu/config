#!/usr/bin/env bash

username=`whoami`
email="yu.ping.hu@gmail.com"

# Clone a git repository if it's not already present, and if it cloned run a command.
function clone() {
  if [ ! -d $2 ]; then
    git clone $1 $2
    eval $3
  fi
}

function add_env() {
  # Tweak .bashrc to add env.sh.
  if ! grep -q "# $username config" ~/.bashrc ; then
    printf '\n# %s config\n. ~/config/env.sh\numask 022\n' $username >> ~/.bashrc
  fi
}

# Link dotfiles from config directory into $HOME.
function link_dotfiles() {
  ln -fs ~/config/gitconfig ~/.gitconfig
  ln -fs ~/config/vimrc ~/.vimrc
}

# Setup various gitconfigurations
function gitconfig() {
  # Set my personal email address in this repository.
  git config user.email yu.ping.hu@gmail.com

  # Setup .gitconfig-more
  printf '[user]\n    email = %s\n[core]\n    autocrlf = input\n' $email > ~/.gitconfig-more
}

## MAIN SCRIPT

if [ -n $1 ]; then
  email=$1
fi

pushd ~/config > /dev/null

add_env
link_dotfiles
gitconfig
mkdir -p ~/tmp

popd > /dev/null
