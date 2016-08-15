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

# OS X: Copy Message attachments
alias cpMessageAttach='mkdir -p $HOME/Downloads/message_attachments && find $HOME/Library/Messages/Attachments -type f -exec cp "{}" $HOME/Downloads/message_attachments \;'
