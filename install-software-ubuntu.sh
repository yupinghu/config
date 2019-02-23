#!/usr/bin/env bash

function snap_install() {
   local -n arr=$1
   for i in "${arr[@]}"
   do
      sudo snap install $i $2
   done
}

# apt
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
)
sudo apt install "${install_list[@]}"

#snaps
snap_list=(
  atom
  chromium
)
snap_install snap_list --classic
sudo wget https://dashboard.snapcraft.io/site_media/appmedia/2017/04/atom-256px.png -O /usr/share/pixmaps/atom.png

# For non work machines this is segregated out so it's easily disabled.
snap_list_work=(
  android-studio
  clion
  slack
)
#snap_install snap_list_work --classic

# Chrome
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo apt install ./google-chrome-stable_current_amd64.deb
#rm google-chrome-stable_current_amd64.deb

if [ -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen -t rsa -b 4096 -C "yu.ping.hu@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
fi

cat ~/.ssh/id_rsa.pub
chromium https://github.com/settings/keys

# TODO: Can this be automated?
gnome_extensions_list=(
  Alternatetab
  Dash to panel
  Panel osd
  Screenshot tool
  Gtile
)
