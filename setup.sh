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

# Clone a git repository if it's not already present, and if it cloned run a command.
function clone() {
  if [ ! -d $2 ]; then
    git clone $1 $2
    eval $3
  fi
}

# Add env.sh to dotfiles.
function add_env() {
  if [ $1 == "mac" ] ; then
    printf '. ~/config/env.sh\n' > ~/.bash_profile
  else
    if ! grep -q "# $username config" ~/.bashrc ; then
      printf '\n# $username config\n. ~/config/env.sh\numask 022\n' >> ~/.bashrc
    fi
  fi
}

# Clone the various solarized repos that I use.
function get_solarized() {
  if [ $1 == "mac" ] ; then
    clone https://github.com/ArtSabintsev/Solarized-Dark-for-Xcode.git solarized.xcode "echo '*** Install Solarized for Xcode'"
    clone https://github.com/tomislav/osx-terminal.app-colors-solarized.git solarized.terminal "echo '*** Import solarized into terminal.app'"
  else
    clone https://github.com/seebi/dircolors-solarized.git solarized.directory "ln -fs $HOME/config/solarized.directory/dircolors.256dark $HOME/.dircolors"
    if [ $1 == "ubuntu" ] ; then
      clone  https://github.com/Anthony25/gnome-terminal-colors-solarized.git solarized.terminal solarized.terminal/install.sh
    fi
  fi
}

# Install desired software from a package manager
function install_software() {
  if [ $1 == "mac" ] ; then
    # Get Homebrew, cask, fonts
    brew_path=$(which brew)
    if [ -z "$brew_path" ] ; then
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    get_tap caskroom/cask
    get_tap caskroom/fonts

    # Get a bunch of software that I like
    get_brew git
    get_cask spectacle
    get_cask google-chrome
    get_cask atom
    # TODO: apm install package-sync
    get_cask font-hack
  else
    # Stuff common to ubuntu and wsl.
    sudo apt-get update
    sudo apt-get install git
    if [ $1 == "ubuntu" ] ; then
      install_list=(
        google-chrome-stable
        redshift
        atom
        fonts-hack-ttf
      )
      sudo apt-get install "${install_list[@]}"
    else
      # Windows: this is just a list of stuff.
      # TODO: Convert to chocolatey? or some other package manager
      # iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
      install_list=(
          https://github.com/oumu/mintty-color-schemes/blob/master/base16-solarized-mod.minttyrc
          https://www.google.com/chrome/browser/desktop/index.html
          https://atom.io/
          apm install package-sync
          https://github.com/source-foundry/Hack-windows-installer/releases/tag/1.2.0
          https://git-scm.com/downloads
          http://store.steampowered.com/
          http://us.battle.net/en/app/
          https://store.unity.com/
          https://github.com/source-foundry/Hack
      )
    fi
  fi
}

# Link dotfiles from config directory into $HOME.
function link_dotfiles() {
  ln -fs ~/config/gitconfig ~/.gitconfig
  ln -fs ~/config/vimrc ~/.vimrc
  if [ $1 == "wsl" ]; then
    pushd /mnt/c/Users/yupin > /dev/null
    if [ ! -h .atom ] ; then
      cmd.exe /c mklink /D .atom c:\\home\\$username\\config\\atom.config
    fi
    cd AppData/Roaming/wsltty
    printf "ThemeFile=c:\home\$username\config\minttyrc\n" > config
    popd > /dev/null
  else
    ln -fs ~/config/atom.config ~/.atom
  fi
}

# Make ~/tmp
function make_tmp() {
  if [ $1 == "wsl" ]; then
    mkdir -p /mnt/c/home/$username/tmp
    ln -fs /mnt/c/home/$username/tmp ~/tmp
  else
    mkdir -p ~/tmp
  fi
}

# Setup various gitconfigurations
function gitconfig() {
  # Set my personal email address in this repository.
  git config user.email yu.ping.hu@gmail.com

  # Setup .gitconfig-more
  printf '[user]\n    email = yu.ping.hu@gmail.com\n' > ~/.gitconfig-more
  if [ $1 == "wsl" ]; then
    printf '[core]\n    autocrlf = true\n' >> ~/.gitconfig-more
  else
    printf '[core]\n    autocrlf = input\n' >> ~/.gitconfig-more
  fi
}

## MAIN SCRIPT

if [ -z $1 ]; then
  echo "Usage: setup.sh [ ubuntu | mac | wsl ]"
  exit 1
fi

if [ $1 != "ubuntu" ] && [ $1 != "mac" ] &&  [ $1 != "wsl" ]; then
  echo "unknown platform $1 (expected 'ubuntu', 'mac', or 'wsl')"
  exit 1
fi

pushd ~ > /dev/null

# For WSL, setup the links from Linux home directory into /mnt/c.
if [ $1 == "wsl" ]; then
  mkdir -p /mnt/c/home/downloads
  ln -fs /mnt/c/home/downloads
  mkdir -p /mnt/c/home/$username
  ln -fs /mnt/c/home/$username winhome
  ln -fs winhome/config
  cd winhome
fi

clone git@github.com:yupinghu/config.git

add_env $1
get_solarized $1
install_software $1
link_dotfiles $1
make_tmp $1
gitconfig $1

popd > /dev/null

exit 0
