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

# Windows: Application aliases (note: need to create these shortcuts too)
alias bnet='start ~/bin/Battle.net.lnk'
alias chrome='start ~/bin/chrome.lnk'
alias discord='start ~/bin/Discord.lnk'
alias steam='start ~/bin/Steam.lnk'
alias unity='start ~/bin/unity.lnk'
