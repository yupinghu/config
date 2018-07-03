# config

yph's dotfiles and new machine setup scripts for Ubuntu, macOS, and Windows (WSL).

## Windows prerequisites

* Install [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about)
* Install [wsltty](https://github.com/mintty/wsltty). This isn't strictly necessary but some of my
  configurations are for wsltty; if you use a different shell, you'll need to adapt those parts.

## How to Use

Run `setup.sh <platform>`, where `<platform>` is one of `ubuntu`, `mac`, or `wsl`. Note that you
can just grab the one file; it will then clone everything into `$HOME/config` and setup symlinks
etc. from `$HOME` into this directory.

If you're setting up for wsl, the script needs to know where your Windows home is (e.g.
`/mnt/c/Users/yph`) in order to link Atom and wsltty configs. By default it uses your linux username
but if it's different you can call `setup.sh wsl [windows_username]`. The script also creates a
Windows symlink which apparently needs to run as administrator.

(Side note: these scripts got started for keeping a consistent setup between a Mac laptop and Ubuntu
workstation; I'm kinda amused that nowadays more and more of it is dedicated to WSL setup.)

Note that my personal email address shows up in this script, when setting up gitconfig files. You
probably want to fix that if you aren't me and are running the script. In general the approach to
email addresses is to not have them be in the checked in `gitconfig` file, to make it easier to
vary them (this is why there's a goofy `.gitconfig-more` file that just gets created by the script).

The script is smart enough to skip steps that appear to already have been performed so it's safe to
run multiple times (e.g. to apply new settings after the script has been changed).

If you have machine-specific stuff to add to your environment, put it in `env-more.sh` in this
directory.
