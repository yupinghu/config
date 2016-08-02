#!/usr/bin/env bash
case $1 in
    osx)
        printf 'PATH=$HOME/bin:$PATH\n. ~/config/env.sh\n' > ~/.bash_profile
        mkdir -p ~/bin
        ln -fs ~/config/osx-emacs.sh ~/bin/emacs
        if [ ! -d solarized.xcode ]; then
            git clone https://github.com/ArtSabintsev/Solarized-Dark-for-Xcode.git solarized.xcode
        fi
        ;;
    ubuntu)
        # TODO: Don't do this if it's already been done
        printf '\n# yph config\n. ~/config/env.sh\n' >> ~/.bashrc
        ;;
    *)
        echo "unknown platform $1"
        exit 1
esac

ln -fs ~/config/$1-emacs.el ~/.emacs
ln -fs ~/config/gitconfig ~/.gitconfig
if [ ! -d solarized.emacs ]; then
    git clone https://github.com/sellout/emacs-color-theme-solarized.git solarized.emacs
fi
