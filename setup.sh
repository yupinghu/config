#!/usr/bin/env bash

## Utility function

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

## MAIN SCRIPT

case $1 in
    mac)
        # Add env.sh to dotfiles.
        printf '. ~/config/env.sh\n' > ~/.bash_profile

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

        # Get solarized
        if [ ! -d solarized.xcode ]; then
            git clone https://github.com/ArtSabintsev/Solarized-Dark-for-Xcode.git solarized.xcode
        fi
        if [ ! -d solarized.terminal ]; then
            git clone https://github.com/tomislav/osx-terminal.app-colors-solarized.git solarized.terminal
            echo "Don't forget to import solarized into terminal.app"
        fi
        ;;
    ubuntu)
        # Add env.sh to dotfiles.
        if ! grep -q "# yph config" ~/.bashrc ; then
            printf '\n# yph config\n. ~/config/env.sh\n' >> ~/.bashrc
        fi

        # Get solarized
        if [ ! -d solarized.terminal ]; then
            git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git solarized.terminal
            solarized.terminal/install.sh
        fi
        if [ ! -d solarized.directory ]; then
            git clone https://github.com/seebi/dircolors-solarized.git solarized.directory
            eval `dircolors ~/config/solarized.directory/dircolors.256dark`
            ln -fs ~/config/solarized.directory/dircolors.256dark ~/.dircolors
        fi

        # Get other stuff
        sudo apt-get update
        install_list=(
            google-chrome-stable
            redshift
            atom
            fonts-hack-ttf
        )
        sudo apt-get install "${install_list[@]}"
        ;;
    windows)
        printf 'cd ~\n. ~/config/env.sh\n' > ~/.bash_profile

        # For now, I'm just putting these here as a way to document what I want to install.
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
        )
        ;;
    wsl)
        # Add env.sh to dotfiles.
        if ! grep -q "# yph config" ~/.bashrc ; then
          printf '\n# yph config\n. ~/config/env.sh\n' >> ~/.bashrc
        fi
        ln -fs ~/config/minttyrc ~/minttyrc
        ;;
    *)
        echo "unknown platform $1"
        exit 1
esac

# Set my personal email address in this repository.
git config user.email yu.ping.hu@gmail.com

# I like me some personal tmp.
mkdir -p ~/tmp

# Create a default .gitconfig-more
printf '[user]\n    email = yu.ping.hu@gmail.com\n' > ~/.gitconfig-more

if [ $1 != "windows" ] ; then
    # Link some dotfiles into $HOME
    ln -fs ~/config/gitconfig ~/.gitconfig
    ln -fs ~/config/atom.config ~/.atom
    ln -fs ~/config/vimrc ~/.vimrc
    # set autocrlf
    printf '[core]\n    autocrlf = input\n' >> ~/.gitconfig-more
else
    # Link dotfiles
    pushd ~
    cmd //c mklink .minttyrc config\\minttyrc
    cmd //c mklink .gitconfig config\\gitconfig
    cmd //c mklink .vimrc config\\vimrc
    cd /c/Users/yupin
    cmd //c mklink /D .atom c:\\home\\yph\\config\\atom.config
    popd
    # set autocrlf
    printf '[core]\n    autocrlf = true\n' >> ~/.gitconfig-more
fi
