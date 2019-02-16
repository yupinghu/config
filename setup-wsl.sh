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
    printf '\n# $username config\n. ~/config/env.sh\numask 022\n' >> ~/.bashrc
  fi
}

# Clone the various solarized repos that I use.
function get_solarized() {
  clone https://github.com/seebi/dircolors-solarized.git solarized.directory "ln -fs $HOME/config/solarized.directory/dircolors.256dark $HOME/.dircolors"
  clone https://github.com/4lex4/intellij-platform-solarized solarized.jetbrains
}

# Install desired software from a package manager
function install_software() {
    sudo apt-get update
    sudo apt-get install git

    # TODO: Convert to chocolatey? or some other package manager
    # iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
    install_list=(
        https://www.google.com/chrome/browser/desktop/index.html
        https://atom.io/
        apm install package-sync
        http://store.steampowered.com/
        http://us.battle.net/en/app/
        https://github.com/source-foundry/Hack
        http://www.randyrants.com/category/sharpkeys/
    )
}

# Link dotfiles from config directory into $HOME.
function link_dotfiles() {
  ln -fs ~/config/gitconfig ~/.gitconfig
  ln -fs ~/config/vimrc ~/.vimrc
  pushd /mnt/c/Users/$windows_username > /dev/null
  # This needs to run as administrator in windows!
  #cmd.exe /c mklink /D .atom c:\\home\\$username\\config\\atom.config
  cd AppData/Roaming/wsltty
  printf "ThemeFile=c:\home\\$username\config\minttyrc\n" > config
  popd > /dev/null
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

# If there's an argument, treat it as the windows username, needed when linking
# atom dotfiles.
if [ ! -z $1 ]; then
  windows_username=$1
fi

pushd /mnt/c/home > /dev/null

install_software
clone git@github.com:yupinghu/config.git

cd ~

# Setup the links from Linux home directory into /mnt/c.
mkdir -p /mnt/c/home/downloads
ln -fs /mnt/c/home/downloads
mkdir -p /mnt/c/home/$username
ln -fs /mnt/c/home/$username winhome
ln -fs winhome/config

cd config

add_env
get_solarized
link_dotfiles
make_tmp
gitconfig

popd > /dev/null

exit 0
