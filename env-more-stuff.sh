#!/usr/bin/env bash

# Some random stuff that might be needed on a per-machine basis.

# make
export MAKEFLAGS='-j8'

# Ubuntu: Switching between docked/undocked
alias scale='gsettings set org.gnome.desktop.interface text-scaling-factor'
alias qq='scale 1.5'
alias ww='scale 1.0'

# Ubuntu: app aliases
alias bgrun='~/config/bgrun.sh'
alias chrome='bgrun google-chrome'
alias steam='bgrun steam'
alias sysprefs='bgrun gnome-control-center'

# MacOS: I like bash.
export BASH_SILENCE_DEPRECATION_WARNING=1
# MacOS: Make sure brew is setup.
eval "$(/usr/local/bin/brew shellenv)"

# MacOS: Copy Message attachments
alias cpMessageAttach='mkdir -p $HOME/Downloads/message_attachments && find $HOME/Library/Messages/Attachments -type f -exec cp "{}" $HOME/Downloads/message_attachments \;'

# MacOS: Application aliases
alias run='open -a'
alias activitymonitor='run "Activity Monitor"'
alias chrome='run "Google Chrome"'
alias facetime='run FaceTime'
alias msg='run Messages'
alias safari='run Safari'
alias slack='run Slack'
alias sysprefs='run "System Preferences"'
alias vscode='run "Visual Studio Code"'

# WSL: Application aliases

# Note that you can also use this to open folders.
alias start="cmd.exe /c start"

# startApp path-to-app exeFileName [params...]
function startApp() {
  start /d "`wslpath -w "$1"`" "${@:2}"
}

# Common locations for use with startApp.
PROGRAM_FILES_PATH='/mnt/c/Program Files'
PROGRAM_FILES_X86_PATH='/mnt/c/Program Files (x86)'
START_MENU_PATH='/mnt/c/ProgramData/Microsoft/Windows/Start Menu/Programs'
LOCAL_APP_PATH='/mnt/c/Users/yupin/AppData/Local'

# Battle.net is weird because the exe name has a space in it, so just run the start menu shortcut.
alias bnet='startApp "$START_MENU_PATH/Battle.net" Battle.net.lnk'
alias calibre='startApp "$PROGRAM_FILES_PATH/Calibre2" calibre.exe'
alias chrome='startApp "$PROGRAM_FILES_X86_PATH/Google/Chrome/Application" chrome.exe'
alias discord='startApp "$LOCAL_APP_PATH/Discord" Update.exe --processStart Discord.exe'
alias kobo='startApp "$PROGRAM_FILES_X86_PATH/Kobo" Kobo.exe'
alias signal='startApp "$LOCAL_APP_PATH/Programs/signal-desktop" Signal.exe'
alias steam='startApp "$PROGRAM_FILES_X86_PATH/Steam" Steam.exe'
alias as='startApp "$PROGRAM_FILES_PATH/Android/Android Studio/bin" studio64.exe'
