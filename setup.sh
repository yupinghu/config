#!/usr/bin/env bash
case $1 in
    osx)
        # Add env.sh to dotfiles.
        printf 'PATH=$HOME/bin:$PATH\n. ~/config/env.sh\n' > ~/.bash_profile
        # Get Homebrew. TODO: Don't even try if it's already installed.
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap caskroom/cask
        # Get a bunch of software that I like
        brew cask install flux
        brew cask install spectacle
        brew install emacs --with-cocoa
        brew cask install google-chrome
        # Link emacs (may be obsolete when I switch to getting emacs via brew)
        mkdir -p ~/bin
        ln -fs ~/config/osx-emacs.sh ~/bin/emacs
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
