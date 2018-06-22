#!/usr/bin/env bash

# Some random stuff that might be needed on a per-machine basis.

# p4
export P4PORT='perforce:1666'
export P4USER='yph'
export P4CLIENT='yph_client'
export P4EDITOR='vim'

# project directories
DEV_ROOT=$HOME/dev

P4_ROOT=$HOME/p4

# Add to path
PATH=$DEV_ROOT:$PATH

# navigation
alias godev='cd $DEV_ROOT'
alias pushdev='pushd $DEV_ROOT'

# make
export MAKEFLAGS='-j8'

# MacOS: Copy Message attachments
alias cpMessageAttach='mkdir -p $HOME/Downloads/message_attachments && find $HOME/Library/Messages/Attachments -type f -exec cp "{}" $HOME/Downloads/message_attachments \;'

# MacOS: Application aliases
alias run='open -a'
alias activitymonitor='run "Activity Monitor"'
alias atom='run atom'
alias c='run Calendar'
alias chrome='run "Google Chrome"'
alias facetime='run FaceTime'
alias m='run Mail'
alias msg='run Messages'
alias safari='run Safari'
alias signal='run signal'
alias siri='run Siri'
alias spectacle='run Spectacle'
alias xcode='run Xcode'

# WSL: Application aliases

# Note that you can also use this to open folders.
alias start="cmd.exe /c start"

function atom() {
  (cd "$1" && cmd.exe /c atom .)
}

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
