#!/usr/bin/env bash

email="yu.ping.hu@gmail.com"

# Clone a git repository if it's not already present, and if it cloned run a command.
function clone() {
  if [ ! -d $2 ]; then
    git clone $1 $2
    eval $3
  fi
}

# Add env.sh to dotfiles.
function add_env() {
  printf '. ~/config/env.sh\n' > ~/.bash_profile
  printf '. ~/config/env.sh\n' > ~/.zshrc
}

# Clone the various solarized repos that I use.
function get_solarized() {
  clone https://github.com/tomislav/osx-terminal.app-colors-solarized.git solarized.terminal "echo '*** Import solarized into terminal.app'"
}

# Link dotfiles from config directory into $HOME.
function link_dotfiles() {
  ln -fs ~/config/gitconfig ~/.gitconfig
  ln -fs ~/config/vimrc ~/.vimrc
}

# Make ~/tmp
function make_tmp() {
  mkdir -p ~/tmp
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

add_env
get_solarized
link_dotfiles
gitconfig
mkdir -p ~/tmp
mkdir -p ~/bin

exit 0
