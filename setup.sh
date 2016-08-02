#!/usr/bin/env bash
case $1 in
    osx)
	printf 'PATH=$HOME/bin:$PATH\n. ~/config/env.sh\n' >> ~/.bash_profile
	mkdir ~/bin
	ln -s ~/config/osx-emacs.sh ~/bin/emacs
	;;
    ubuntu)
	printf '\n# yph config\n. ~/config/env.sh\n' >> ~/.bashrc
	;;
    *)
	echo "unknown platform $1"
	exit 1
esac

ln -s ~/config/$1-emacs.el ~/.emacs
#git clone https://github.com/sellout/emacs-color-theme-solarized.git solarized.emacs

if [[ $2 == "dev" ]]; then
    printf "\n# Dev environment setup\n. ~/config/env-dev.sh\n" >> env.sh
    ln -s ~/config/gitconfig ~/.gitconfig
fi
