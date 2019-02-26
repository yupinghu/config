#!/usr/bin/env bash

# Function to install a list of snaps.
function snap_install() {
   local -n arr=$1
   for i in "${arr[@]}"
   do
      sudo snap install $i $2
   done
}

# MAIN SCRIPT

printf "*** Step 1: apt packages ***\n"
sudo apt-add-repository ppa:tista/adapta
sudo apt update
sudo apt upgrade
install_list=(
  git
  vim
  gnome-tweak-tool
  gnome-shell-extensions
  chrome-gnome-shell
  fonts-hack
  fonts-roboto
  adapta-gtk-theme
)
sudo apt install "${install_list[@]}"

printf "\n*** Step 2: snaps, part 1***\n"
snap_list=(
  atom
)
snap_install snap_list --classic
# Fix the atom icon (the snap doesn't seem to install this correctly)
sudo wget https://dashboard.snapcraft.io/site_media/appmedia/2017/04/atom-256px.png -O /usr/share/pixmaps/atom.png

if [ $1 == "work" ]; then
  printf "\n*** Step 3: snaps, part 2 (work-related snaps) ***\n"
  snap_list_work=(
    android-studio
    clion
    slack
  )
  snap_install snap_list_work --classic
else
  printf "\n*** Step 3 skipped (work not specified) ***\n"
fi

printf "\n*** Step 4: Chrome ***\n"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

printf "\n*** Step 5: Generate SSH key ***\n"
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -C "yu.ping.hu@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
fi

printf "\n*** Step 6: Open github in chrome so you can add your SSH key ***\n"
cat ~/.ssh/id_rsa.pub
google-chrome https://github.com/settings/keys

printf "\n*** Next step: git clone git@github.com:yupinghu/config.git ***\n"

# TODO: Can this be automated?
gnome_extensions_list=(
  Alternatetab
  Dash to panel
  Panel osd
  Screenshot tool
  Gtile
)
