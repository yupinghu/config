#!/usr/bin/env bash

username=`whoami`

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
    printf "\n# $username config\n. ~/config/env.sh\numask 022\n" >> ~/.bashrc
  fi
}

# Clone the various solarized repos that I use.
function get_solarized() {
  clone https://github.com/seebi/dircolors-solarized.git solarized.directory "ln -fs $HOME/config/solarized.directory/dircolors.256dark $HOME/.dircolors"
  clone  https://github.com/Anthony25/gnome-terminal-colors-solarized.git solarized.terminal solarized.terminal/install.sh
  # JetBrains IDEs
  clone https://github.com/4lex4/intellij-platform-solarized solarized.jetbrains
}

# Install desired software from a package manager
function install_software() {
  sudo apt update
  install_list=(
    git
    vim
    gnome-tweak-tool
    gnome-shell-extensions
    chrome-gnome-shell
    fonts-hack
    fonts-roboto
  )
  sudo apt install "${install_list[@]}"

  snap_list_classic=(
    android-studio
    atom
    clion
    slack
  )
  sudo snap install "${snap_list_classic[@]}" --classic

  # Chrome
  # TODO: Chromium?
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg –i google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb

  # TODO: Can this be automated?
  gnome_extensions_list=(
    Alternatetab
    Dash to panel
    Panel osd
    Screenshot tool
    Gtile
  )
}

# Link dotfiles from config directory into $HOME.
function link_dotfiles() {
  ln -fs ~/config/gitconfig ~/.gitconfig
  ln -fs ~/config/vimrc ~/.vimrc
  ln -fs ~/config/atom.config ~/.atom
}

# Setup various gitconfigurations
function gitconfig() {
  # Set my personal email address in this repository.
  git config user.email yu.ping.hu@gmail.com

  # Setup .gitconfig-more
  printf '[user]\n    email = yu.ping.hu@gmail.com\n[core]\n    autocrlf = input\n' > ~/.gitconfig-more
}

## MAIN SCRIPT

pushd ~ > /dev/null

# First things first: Get software, including git.
install_software $1

clone git@github.com:yupinghu/config.git

cd config

add_env $1
get_solarized $1
link_dotfiles $1
gitconfig $1
mkdir -p ~/tmp

printf '\n\n*** THINGS YOU STILL NEED TO DO ***\n\n'
echo '* Update your .gitconfig-more as appropriate'
echo '* Dork with gnome-tweaks'

popd > /dev/null

exit 0
