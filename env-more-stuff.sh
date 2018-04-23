#!/usr/bin/env bash

# Some random stuff that might be needed on a per-machine basis.

# p4
export P4PORT='perforce:1666'
export P4USER='yph'
export P4CLIENT='yph_client'
export P4EDITOR='emacs -nw'

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
function atom() {
  (cd "$1" && cmd.exe /c atom .)
}

# Note that you can also use this to open folders.
alias start="cmd.exe /c start"

# Start apps where they live.
runInDir() {
  (cd "$1/$2" && shift && shift && start $@)
}
runProgram() {
  runInDir "/mnt/c/Program Files" "$@"
}
runX86Program() {
  runInDir "/mnt/c/Program Files (x86)/" "$@"
}
runLocalApp() {
  runInDir "/mnt/c/Users/yupin/AppData/Local" "$@"
}

alias bnet='runX86Program Battle.net Battle.net Launcher.exe'
alias calibre='runProgram Calibre2 calibre.exe'
alias chrome='runX86Program Google/Chrome/Application chrome.exe'
alias discord='runLocalApp Discord Update.exe --processStart Discord.exe'
alias kobo='runX86Program Kobo Kobo.exe'
alias signal='runLocalApp Programs/signal-desktop Signal.exe'
alias steam='runX86Program Steam Steam.exe'
alias as='runProgram "Android/Android Studio/bin" studio64.exe'
