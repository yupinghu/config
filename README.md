# config

yph's dotfiles and new machine setup scripts for Ubuntu, macOS, and Windows (WSL).

## Ubuntu

Run the following commands:
```
wget https://raw.githubusercontent.com/yupinghu/config/master/ubuntu-install-software.sh
. ubuntu-install-software.sh
rm ubuntu-install-software.sh
# Add your ssh keys to github
git clone git@github.com:yupinghu/config.git
cd config
./setup-ubuntu.sh
```

It's not all one script so that you can install your ssh keys to github before cloning.

## Windows

* Install [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about)
* Install [wsltty](https://github.com/mintty/wsltty). This isn't strictly necessary but some of my
  configurations are for wsltty; if you use a different shell, you'll need to adapt those parts.


## How to Use

Run `setup-<platform>.sh`, where `<platform>` is one of `ubuntu`, `mac`, or `wsl`. Note that you
can just grab the one file; it will then clone everything into `$HOME/config` and setup symlinks
etc. from `$HOME` into this directory.

If you're setting up for wsl, the script needs to know where your Windows home is (e.g.
`/mnt/c/Users/yph`) in order to link Atom and wsltty configs. By default it uses your linux username
but if it's different you can provide it as an argument to `setup-wsl.sh`. There are two parts of
the script which currently aren't correctly automated:

* Atom config directory is symlinked in Windows, but this must run as an administrator in Windows.
  The line in the script for now can be copy/pasted into an Administrator PowerShell.
* Software installation is sadly not automated; it's just a link of websites to where to get the
  installers.

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
