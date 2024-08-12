#!/usr/bin/env bash

# Homebrew wrapper functions
function get_tap() {
  if ! brew tap | grep -q "$1" 2> /dev/null ; then
    brew tap $1
  fi
}

function brew_install() {
  if ! brew list | grep -q "$1" 2> /dev/null ; then
    brew install $1 $2
  fi
}

# MAIN SCRIPT

# Get Homebrew
brew_path=$(which brew)
if [ -z "$brew_path" ] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
get_tap homebrew/cask
get_tap homebrew/cask-fonts

# Install stuff
brew_install font-hack
brew_install git
brew_install google-chrome
brew_install rectangle
brew_install ripgrep
brew_install visual-studio-code

mkdir -p ~/tmp
mkdir -p ~/bin

# Get and run the common setup script.
wget https://raw.githubusercontent.com/yupinghu/config/master/setup-common.sh -O ~/tmp/setup-common.sh
~/tmp/setup-common.sh
rm ~/tmp/setup-common.sh

if [ ! -d ~/config/solarized.terminal ]; then
  git clone https://github.com/tomislav/osx-terminal.app-colors-solarized.git ~/config/solarized.terminal
  echo "*** Import solarized into terminal.app"
fi

echo "*** Don't forget to import Rectangle configs."
