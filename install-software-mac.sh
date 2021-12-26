#!/usr/bin/env bash

username=`whoami`

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

pushd ~ > /dev/null

printf "*** Step 1: get homebrew ***\n"
brew_path=$(which brew)
if [ -z "$brew_path" ] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
get_tap homebrew/cask
get_tap homebrew/cask-fonts

printf "*** Step 2: get basic software ***\n"
brew_install atom
brew_install google-chrome
brew_install font-hack
# brew_install karabiner-elements
brew_install rectangle

# Upgrade bash
if [ -z /usr/local/bin/bash ] ; then
  brew_install bash
  sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
  chsh -s /usr/local/bin/bash
fi
brew_install git
brew_install bash-completion

# TODO: apm install package-sync

printf "\n*** Step 3: Generate SSH key ***\n"
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -C "yu.ping.hu@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
fi

printf "\n*** Step 4: Open github in chrome so you can add your SSH key ***\n"
cat ~/.ssh/id_rsa.pub
open -a "Google Chrome" https://github.com/settings/keys

printf "\n*** Step 5: git clone git@github.com:yupinghu/config.git ***\n"
git clone git@github.com:yupinghu/config.git config

# Work related stuff
# brew_install google-cloud-sdk
# brew_install visual-studio-code
# brew_install go
# brew_install kubernetes-cli
# brew_install kubernetes-helm
# brew_install protobuf

popd > /dev/null
exit 0
