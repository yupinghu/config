#!/usr/bin/env bash

# Aliases relating to this file
ENV_FILE=~/config/env.sh
alias realias='source $ENV_FILE'
alias reenv='source $ENV_FILE'
alias catenv='cat $ENV_FILE'

# Path setup
# Store the path that existed before the first time we load this file, so that reloading
# doesn't just add the same stuff over and over.
if [ -z ${BASE_PATH+x} ]; then
    export BASE_PATH=$PATH
fi
# Reset the path now, and downstream guys can add to it with the "normal" mechanism.
PATH=$BASE_PATH

if [ -z ${USERNAME+x} ]; then
    export USENAME=$USER
fi

# basic aliases
alias ll='ls -alGF'
alias la='ls -AGF'
alias l='ls -CGF'
alias tidy='rm -f *~ .*~'
alias em='emacs'
alias e='emacs -nw'

# git
alias gb='git co' # git branch
alias gub='git rebase origin/master' # git update branch
gnb() { # create new branch based on master
  git checkout -b $1 master
}
gsync() { # syncs from origin, updates local master, and rebases current branch.
  currentBranch=`git branch | grep "*"`
  currentBranch=${currentBranch/* /}
  git update origin
  git rebase origin/master master
  git rebase origin/master $currentBranch
}

# Git prompt
. ~/config/git-prompt.sh
GIT_PS1_DESCRIBE_STYLE='describe'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__git_ps1 "\[\033[36m\]\u@\h\[\033[0m\]:\[\033[35m\]\w\[\033[0m\]" "\\\$ " && echo -ne "\033]0;${USERNAME}@${HOSTNAME}: ${PWD}\007"'

# Steam stuff
#alias steam="LD_PRELOAD='/usr/\$LIB/libstdc++.so.6' DISPLAY=:0 /usr/bin/steam"
# Exec=env LD_PRELOAD="/usr/\$LIB/libstdc++.so.6" /usr/bin/steam %U

# Load per-machine (or otherwise not in git) files.
if [ -a ~/config/env-more.sh ]; then
    . ~/config/env-more.sh
fi
