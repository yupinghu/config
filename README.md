# config

yph's dotfiles and new machine setup scripts for Ubuntu, macOS, and Windows (WSL).

## Windows prerequisites

* Install [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about)
* Install [wsltty](https://github.com/mintty/wsltty). This isn't strictly necessary but some of my
  configurations are for wsltty; if you use a different shell, you'll need to adapt those parts.

Some notes about some goofy stuff with WSL:

* The setup script hardcodes my Windows username (look for `yupin`) when setting the symlink to the
  atom config directory. I'll fix this when they add
  [environment variable sharing](https://blogs.msdn.microsoft.com/commandline/2017/12/22/share-environment-vars-between-wsl-and-windows/).
* I added a wrapper bat file for git, but Jetbrains IDEs don't deal with it well. So, I had to
  resort to installing git for Windows as well as using git in Ubuntu, which is lame, but oh well.

## How to Use

Run `setup.sh <platform>`, where `<platform>` is one of `ubuntu`, `mac`, or `wsl`. Note that you
can just grab the one file; it will then clone everything into `$HOME/config` and setup symlinks
etc. from `$HOME` into this directory.

The script is smart enough to skip steps that appear to already have been performed so it's safe to
run multiple times (e.g. to apply new settings after the script has been changed).

If you have machine-specific stuff to add to your environment, put it in `env-more.sh` in this
directory.
