#!/usr/bin/env bash

# The config repo sets its email address as $personal_email, while the global .gitconfig uses
# $git_email. This prevents my work email address from getting into the config repo history.
personal_email="yu.ping.hu@gmail.com"
git_email=$personal_email

# Setup ssh keys.
if [ ! -f ~/.ssh/id_ed25519.pub ]; then
  ssh-keygen -t ed25519 -C "default"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
    printf "Add your ssh key to github (https://github.com/settings/keys):\n\n"
    cat ~/.ssh/id_ed25519.pub
    printf "\nPress enter to continue...\n"
    read
fi

# Get the config repo.
if [ ! -d ~/config ]; then
  git clone git@github.com:yupinghu/config.git ~/config
  (cd ~/config && git config user.email $personal_email)
  git config --global include.path ~/config/gitconfig
  git config --global user.email $git_email
fi

# Setup dotfiles.
printf '. ~/config/env.sh\numask 022\n' > ~/.zshrc
ln -fs ~/config/vimrc ~/.vimrc

echo "*** Set your wallpaper"
