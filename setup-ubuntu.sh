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
  # Tweak .xinitrc to add media key bindings.
  if ! test -r .xinitrc || ! grep -q "xmodmap" ~/.xinitrc ; then
    printf "\nxmodmap ~/config/mediakeys.xmodmap\n" >> ~/.xinitrc
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
  )
  sudo apt install "${install_list[@]}"

  # TODO: Add the correct repositories needed for these, and then add to the list above.
  install_list_more=(
    google-chrome-stable
    atom
    fonts-hack-ttf
  )
  # TODO: Can this be automated?
  gnome_extensions_list=(
    Alternatetab
    Clipboard indicator
    Dash to panel
    Openweather
    Panel osd
    Removable drive menu
    Remove dropdown arrows
    Screenshot tool
    Gtile
    System-monitor
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

# First things first: Get software, including git.
install_software $1

pushd ~/config > /dev/null

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
