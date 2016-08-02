#!/usr/bin/env bash

# Aliased for reloading this file
alias realias='source ~/config/env.sh'
alias reenv='source ~/config/env.sh'

# Path setup
# Store the path that existed before the first time we load this file, so that reloading
# doesn't just add the same stuff over and over.
if [ -z ${BASE_PATH+x} ]; then
    export BASE_PATH=$PATH
fi
# Reset the path now, and downstream guys can add to it with the "normal" mechanism.
PATH=$BASE_PATH

# Prompt
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ "

# basic aliases
alias ll='ls -alGF'
alias la='ls -AGF'
alias l='ls -CGF'
alias tidy='rm -f *~ .*~'
alias em='emacs'
alias e='emacs -nw'

# Steam stuff
#alias steam="LD_PRELOAD='/usr/\$LIB/libstdc++.so.6' DISPLAY=:0 /usr/bin/steam"
# Exec=env LD_PRELOAD="/usr/\$LIB/libstdc++.so.6" /usr/bin/steam %U

. ~/config/env-dev.sh
