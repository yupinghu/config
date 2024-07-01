#!/usr/bin/env bash

# Some random stuff that might be needed on a per-machine basis.

### UBUNTU ###

# Laptop: Switching between docked/undocked
alias scale='gsettings set org.gnome.desktop.interface text-scaling-factor'
alias qq='scale 1.5'
alias ww='scale 1.0'

# App aliases
alias bgrun='~/config/bgrun.sh'
alias chrome='bgrun google-chrome'
alias steam='bgrun steam'

### MacOS ###

# Copy Message attachments
alias cpMessageAttach='mkdir -p $HOME/Downloads/message_attachments && find $HOME/Library/Messages/Attachments -type f -exec cp "{}" $HOME/Downloads/message_attachments \;'

#App aliases
alias run='open -a'
alias activitymonitor='run "Activity Monitor"'
alias chrome='run "Google Chrome"'
alias facetime='run FaceTime'
alias msg='run Messages'
alias safari='run Safari'
alias slack='run Slack'
alias sysprefs='run "System Preferences"'
alias vscode='run "Visual Studio Code"'

### WSL ###

# Note that you can also use this to open folders.
alias start="cmd.exe /c start"

# startApp path-to-app exeFileName [params...]
# cmd.exe complains if its working directory is in WSL.
function startApp() {
  (cd /mnt/c && start /d "`wslpath -w "$1"`" "${@:2}")
}

function startWinStoreApp() {
  (cd /mnt/c && start "shell:AppsFolder\\$1")
}

# Common locations for use with startApp.
PROGRAM_FILES_PATH='/mnt/c/Program Files'
PROGRAM_FILES_X86_PATH='/mnt/c/Program Files (x86)'
START_MENU_PATH='/mnt/c/ProgramData/Microsoft/Windows/Start Menu/Programs'
WINHOME_PATH='/mnt/c/Users/yupin'
WINHOME_START_MENU_PATH="$WINHOME_PATH/AppData/Roaming/Microsoft/Windows/Start Menu/Programs"
LOCAL_APP_PATH="$WINHOME_PATH/AppData/Local"

# Battle.net is weird because the exe name has a space in it, so just run the start menu shortcut.
alias amzngames='startApp "$WINHOME_START_MENU_PATH" AmazonGames.lnk'
alias bnet='startApp "$START_MENU_PATH/Battle.net" Battle.net.lnk'
alias calibre='startApp "$PROGRAM_FILES_PATH/Calibre2" calibre.exe'
alias chrome='startApp "$PROGRAM_FILES_X86_PATH/Google/Chrome/Application" chrome.exe'
alias discord='startApp "$LOCAL_APP_PATH/Discord" Update.exe --processStart Discord.exe'
alias ea='startApp "$PROGRAM_FILES_PATH/Electronic Arts/EA Desktop/EA Desktop" EALauncher.exe'
alias epic='startApp "$PROGRAM_FILES_X86_PATH/Epic Games/Launcher/Portal/Binaries/Win32" EpicGamesLauncher.exe'
alias gplay='startApp "$PROGRAM_FILES_PATH/Google/Play Games" Bootstrapper.exe'
alias itunes='startWinStoreApp "AppleInc.iTunes_nzyj5cx40ttqa!iTunes"'
alias kobo='startApp "$PROGRAM_FILES_X86_PATH/Kobo" Kobo.exe'
alias music='startWinStoreApp "AppleInc.AppleMusicWin_nzyj5cx40ttqa!App"'
alias signal='startApp "$LOCAL_APP_PATH/Programs/signal-desktop" Signal.exe'
alias slack='startApp "$PROGRAM_FILES_PATH/Slack" slack.exe'
alias steam='startApp "$PROGRAM_FILES_X86_PATH/Steam" Steam.exe'

# Mount USB drives
alias usbmount='sudo mount -t drvfs d: ~/mnt/d'
alias usbumount='sudo umount ~/mnt/d'

# 2 way copy of data with USB drive
# Always just copy, no deletes -- that will have to be solved manually.
alias rclone_cmd='sudo rclone copy -v --stats-one-line --no-update-modtime'
alias rclone_to='rclone_cmd /mnt/c/data/records ~/mnt/d/data/records'
alias rclone_from='rclone_cmd ~/mnt/d/data/records /mnt/c/data/records'
alias rbackup='usbmount && rclone_to && rclone_from && usbumount'
