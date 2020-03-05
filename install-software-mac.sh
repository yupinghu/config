#!/usr/bin/env bash

username=`whoami`

# Homebrew wrapper functions
function get_tap() {
  if ! brew tap | grep -q "$1" 2> /dev/null ; then
    brew tap $1
  fi
}

function get_brew() {
  if ! brew list | grep -q "$1" 2> /dev/null ; then
    brew install $1 $2
  fi
}

function get_cask() {
  if ! brew cask list | grep -q "$1" 2> /dev/null ; then
    brew cask install $1
  fi
}

# MAIN SCRIPT

pushd ~ > /dev/null

printf "*** Step 1: get homebrew ***\n"
brew_path=$(which brew)
if [ -z "$brew_path" ] ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
get_tap caskroom/cask
get_tap caskroom/fonts

printf "*** Step 2: get basic software ***\n"
get_cask atom
get_cask google-chrome
get_cask font-hack
get_cask karabiner-elements
get_cask spectacle

# Upgrade bash
if [ -z /usr/local/bin/bash ] ; then
  get_brew bash
  sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
  chsh -s /usr/local/bin/bash
fi
get_brew git
get_brew bash-completion

# TODO: apm install package-sync

printf "\n*** Step 3: Generate SSH key ***\n"
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -C "yu.ping.hu@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
fi

printf "\n*** Step 4: Open github in chrome so you can add your SSH key ***\n"
cat ~/.ssh/id_rsa.pub
google-chrome https://github.com/settings/keys

printf "\n*** Step 5: git clone git@github.com:yupinghu/config.git ***\n"
git clone git@github.com:yupinghu/config.git config

# Work related stuff
# get_cask google-cloud-sdk
# get_cask visual-studio-code
# get_brew go
# get_brew kubernetes-cli
# get_brew kubernetes-helm
# get_brew protobuf

popd > /dev/null
exit 0
