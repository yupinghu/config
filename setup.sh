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
        get_brew emacs --with-cocoa
        get_brew git
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
            echo "Don't forget to import solarized into terminal.app"
        fi

        # Change font smoothing in emacs & Xcode, because the default value makes text look fat.
        # Currently disabled because fat is better than ugly, but would LOVE to fix this long term.
        # defaults write org.gnu.Emacs AppleFontSmoothing -int 0
        # defaults write com.apple.dt.Xcode AppleFontSmoothing -int 0
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
            emacs24
            google-chrome-stable
            redshift
            typecatcher
        )
        sudo apt-get install "${install_list[@]}"
        if [ ! -e "$HOME/.fonts/typecatcher/Roboto Mono_regular.ttf" ] ; then
            echo "Launching typecatcher, install Roboto Mono"
            typecatcher
        fi
        ;;
    windows)
        printf 'cd ~\n. ~/config/env.sh\n' > ~/.bash_profile
        cp ~/config/gitconfig ~/.gitconfig
        cp ~/config/minttyrc ~/.minttyrc
        # For now, I'm just putting these here as a way to document what I want to install.
        # TODO: Convert to chocolatey? or some other package manager
        # iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
        install_list=(
            https://github.com/oumu/mintty-color-schemes/blob/master/base16-solarized-mod.minttyrc
            https://www.google.com/chrome/browser/desktop/index.html
            https://fonts.google.com/specimen/Roboto+Mono
            https://atom.io/
            https://git-scm.com/downloads
            http://store.steampowered.com/
            http://us.battle.net/en/app/
            https://store.unity.com/
        )
        ;;
    *)
        echo "unknown platform $1"
        exit 1
esac

# I like me some personal tmp.
mkdir -p ~/tmp

if [ $1 != "windows" ] ; then
    # Link some dotfiles into $HOME
    ln -fs ~/config/$1-emacs.el ~/.emacs
    ln -fs ~/config/gitconfig ~/.gitconfig

    # Get solarized for emacs.
    if [ ! -d solarized.emacs ]; then
        git clone https://github.com/sellout/emacs-color-theme-solarized.git solarized.emacs
    fi
fi
