# config

yph's dotfiles and new machine setup scripts for Ubuntu, macOS, and Windows (WSL).

Note that my personal email address shows up in these scripts. You probably want to fix that if you
aren't me and are running the script. In general the approach to email addresses is to not have them
be in the checked in `gitconfig` file, to make it easier to vary them (this is why there's a goofy
`.gitconfig-more` file that just gets created by the script).

The scripts are smart enough to skip steps that appear to already have been performed so it's safe
to run multiple times (e.g. to apply new settings after the script has been changed).

If you have machine-specific stuff to add to your environment, put it in `env-more.sh` in this
directory.

## Ubuntu

Run the following commands:
```
wget https://raw.githubusercontent.com/yupinghu/config/master/install-software-ubuntu.sh
. install-software-ubuntu.sh
rm install-software-ubuntu.sh
git clone git@github.com:yupinghu/config.git
cd config
./setup-ubuntu.sh
```

It's not all one script so that you can install your ssh keys to github before cloning. The first
script will open chromium to the appropriate page to do this.

## Windows

First install my favorite Windows software, including WSL (run as administrator):
```
powershell (new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/yupinghu/config/master/install-software-windows.bat','install-software-windows.bat')
install-software-windows
del install-software-windows.bat
```

Then run the following from an Ubuntu terminal:
```
wget https://raw.githubusercontent.com/yupinghu/config/master/setup-wsl.sh
. setup-wsl.sh
rm setup-wsl.sh
```

(Side note: these scripts got started for keeping a consistent setup between a Mac laptop and Ubuntu
workstation; I'm kinda amused that nowadays more and more of it is dedicated to WSL setup.)
