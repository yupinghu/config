# config

yph's dotfiles and new machine setup scripts for Ubuntu, macOS, and Windows (WSL).

## Windows prerequisites

* Install [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about)
* Install [wsltty](https://github.com/mintty/wsltty). This isn't strictly necessary but some of my
  configurations are for wsltty; if you use a different shell, you'll need to adapt those parts.

## How to Use

Run `setup.sh <platform>`, where `<platform>` is one of `ubuntu`, `mac`, or `wsl`. Note that you
can just grab the one file; it will then clone everything into `~/config` and setup symlinks etc.
from `$HOME` into this directory.

The script is smart enough to skip steps that appear to already have been performed so it's safe to
run multiple times (e.g. to apply new settings after the script has been changed).

If you have machine-specific stuff to add to your environment, put it in `env-more.sh` in this
directory.
