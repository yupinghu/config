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

function apt_get() {
    echo "WARNING: Haven't set up the right apt-get for $1 yet"
}

## MAIN SCRIPT

case $1 in
    osx)
        # Add env.sh to dotfiles.
        printf 'PATH=$HOME/bin:$PATH\n. ~/config/env.sh\n' > ~/.bash_profile

        # Get Homebrew, cask, fonts
        brew_path=$(which brew)
        if [ -z "$brew_path" ] ; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi
        get_tap caskroom/cask
        get_tap caskroom/fonts

        # Get a bunch of software that I like
        get_brew emacs --with-cocoa
        get_cask flux
        get_cask spectacle
        get_cask google-chrome
        get_cask font-roboto-mono

        # Get solarized
        if [ ! -d solarized.xcode ]; then
            git clone https://github.com/ArtSabintsev/Solarized-Dark-for-Xcode.git solarized.xcode
        fi
        if [ ! -d solarized.terminal ]; then
            git clone https://github.com/tomislav/osx-terminal.app-colors-solarized.git solarized.terminal
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
        apt_get emacs
        apt_get chrome
        apt_get redshift
        apt_get typecatcher
        apt_get roboto-mono
        ;;
    *)
        echo "unknown platform $1"
        exit 1
esac

mkdir -p ~/tmp
ln -fs ~/config/$1-emacs.el ~/.emacs
ln -fs ~/config/gitconfig ~/.gitconfig
if [ ! -d solarized.emacs ]; then
    git clone https://github.com/sellout/emacs-color-theme-solarized.git solarized.emacs
fi
