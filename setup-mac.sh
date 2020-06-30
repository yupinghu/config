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
}

# Clone the various solarized repos that I use.
function get_solarized() {
  #clone https://github.com/ArtSabintsev/Solarized-Dark-for-Xcode.git solarized.xcode "echo '*** Install Solarized for Xcode'"
  clone https://github.com/tomislav/osx-terminal.app-colors-solarized.git solarized.terminal "echo '*** Import solarized into terminal.app'"

  # JetBrains IDEs
  clone https://github.com/4lex4/intellij-platform-solarized solarized.jetbrains
}

# Link dotfiles from config directory into $HOME.
function link_dotfiles() {
  ln -fs ~/config/gitconfig ~/.gitconfig
  ln -fs ~/config/vimrc ~/.vimrc
  ln -fs ~/config/atom.config ~/.atom
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

pushd ~ > /dev/null

clone git@github.com:yupinghu/config.git config
cd config

add_env
get_solarized
link_dotfiles
gitconfig
mkdir -p ~/tmp

popd > /dev/null

exit 0
