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

# Clone the various solarized repos that I use.
function get_solarized() {
  clone https://github.com/seebi/dircolors-solarized.git solarized.directory "ln -fs $HOME/config/solarized.directory/dircolors.256dark $HOME/.dircolors"
  clone  https://github.com/Anthony25/gnome-terminal-colors-solarized.git solarized.terminal solarized.terminal/install.sh
  # JetBrains IDEs
  clone https://github.com/4lex4/intellij-platform-solarized solarized.jetbrains
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
  printf '[user]\n    email = %s\n[core]\n    autocrlf = input\n' $email > ~/.gitconfig-more
}

## MAIN SCRIPT

if [ -n $1 ]; then
  email=$1
fi

pushd ~/config > /dev/null

add_env
get_solarized
link_dotfiles
gitconfig
mkdir -p ~/tmp

printf '\n\n*** THINGS YOU STILL NEED TO DO ***\n\n'
echo '* Update your .gitconfig-more as appropriate'
echo '* Dork with gnome-tweaks'

gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 5000

popd > /dev/null

exit 0
