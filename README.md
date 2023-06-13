# config

yph's dotfiles and new machine setup scripts for Ubuntu, macOS, and Windows (WSL).

If you aren't me, you should edit [setup-common.sh](setup-common.sh) to change the email addresses
to your own. (Even if you are me, if it's a work computer, you should set the work email address.)

If you have machine-specific stuff to add to your environment, put it in `env-more.sh` in this
directory.

## Windows only

This is a two step process: Installing stuff in Windows, and then doing the normal setup in WSL.

To do the first part, run the following as administrator:

```
powershell (new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/yupinghu/config/master/install-software-windows.bat','install-software-windows.bat')
install-software-windows
del install-software-windows.bat
```

## All Platforms

Get and run the platform specific setup script:
```
wget https://raw.githubusercontent.com/yupinghu/config/master/setup-$PLATFORM.sh
. setup-$PLATFORM.sh
rm setup-$PLATFORM.sh
```

## Historical Note

These scripts got started when I needed to keep a consistent setup between a Macbook and an Ubuntu
workstation. I'm amused that managing my WSL setup has become a big part of this repo, while Ubuntu
scripts are neglected (outside of WSL stuff).
