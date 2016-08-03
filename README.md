# config
yph's dotfiles and new machine setup scripts

## Basic info

Clone this to `~/config` and run `setup.sh <platform>`, where `<platform>` is either `osx` or `ubuntu`.
For `osx` it's safe to run `setup.sh` repeatedly, for `ubuntu` it'll currently litter up your `.bashrc`.

If you have machine-specific stuff to add to your environment, put it in `env-more.sh` in this directory.

You might ask: if this script is supposed to set up a fresh machine, how do I clone without git? To which I say, shut up and get git first. :)

## Other software to install

### OS X
These should just get added to setup.sh the next time I run it.
- [Homebrew](http://brew.sh/) and brew cask
- [F.lux](https://justgetflux.com/) `brew cask install flux`
- [Spectacle](https://www.spectacleapp.com/) `brew cask install spectacle`
- [Emacs](https://emacsformacosx.com/) `brew install emacs --with-cocoa`
- [Chrome](https://www.google.com/chrome/browser/desktop/index.html) `brew cask install google-chrome`

### Other stuff
- [Roboto Mono](https://fonts.google.com/specimen/Roboto+Mono?query=roboto&category=Monospace&selection.family=Roboto+Mono)
- [Solarized](http://ethanschoonover.com/solarized)
