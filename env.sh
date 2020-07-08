#!/usr/bin/env bash

# Aliases relating to this file
ENV_FILE=~/config/env.sh
ENV_MORE_FILE=~/config/env-more.sh
alias realias='source $ENV_FILE'
alias reenv='source $ENV_FILE'
alias catenv='cat $ENV_FILE'
alias catenvmore='cat $ENV_MORE_FILE'
alias editenv='vim $ENV_MORE_FILE'

# Path setup
# Store the path that existed before the first time we load this file, so that reloading
# doesn't just add the same stuff over and over.
if [ -z ${BASE_PATH+x} ]; then
    export BASE_PATH=$PATH
fi
# Reset the path now, and downstream guys can add to it with the "normal" mechanism.
PATH=$BASE_PATH

if [ -z ${USERNAME+x} ]; then
    export USERNAME=$USER
fi

alias grp='grep -r -I --exclude-dir=_* --exclude-dir=build --exclude-dir=cmake-build* --exclude-dir=obj --exclude-dir=dst --exclude-dir=*xcodeproj'

# basic aliases
if [[ `uname` == 'Darwin' ]]; then
  alias ll='ls -alGF'
  alias la='ls -AGF'
  alias l='ls -CGF'
else
  alias ll='ls -alF --color=auto'
  alias la='ls -AF --color=auto'
  alias l='ls -CF --color=auto'
fi
alias tidy='rm -f *~ .*~'

# git
alias gb='git co' # git branch
alias gub='git rebase origin/master' # git update branch
gnb() { # create new branch based on master
  git checkout -b $1 master
}

# syncs from origin, updates local master, and rebases current branch.
unset GIT_PARENTS
if (( BASH_VERSINFO[0] > 3 )); then
  declare -A GIT_PARENTS
fi

gsync() {
  currentBranch=`git rev-parse --abbrev-ref HEAD`
  git rev-parse --verify develop &> /dev/null
  if [ $? == 0 ]; then
    mainBranch='develop'
  else
    mainBranch='master'
  fi
  echo "* Updating $mainBranch"
  git update origin
  git rebase origin/$mainBranch $mainBranch
  if [[ ${GIT_PARENTS[$currentBranch]+_} ]]; then
    parentBranch=${GIT_PARENTS[$currentBranch]}
  else
    parentBranch=$mainBranch
  fi
  echo "* Rebasing $currentBranch onto origin/$parentBranch"
  git rebase origin/$parentBranch $currentBranch
}

gcpt() {
  topCommit=`git rev-parse --verify $1`
  git branch -f $1 HEAD
  git co $1
  git cp $topCommit
}

createremotebranch() { # Start a new branch based on current branch and push it.
  git co -b yph/$1
  git push --set-upstream origin yph/$1
}

# Git prompt
if [ "$(uname)" == "Darwin" ]; then
  PROMPT_HEADER_COLOR="34"
else
  PROMPT_HEADER_COLOR="31"
fi
. ~/config/git-prompt.sh
GIT_PS1_DESCRIBE_STYLE='describe'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__git_ps1 "\033[${PROMPT_HEADER_COLOR}m\][$(uname)]\033[0m\] \033[36m\]\u@\h\[\033[0m\]:\[\033[35m\]\w\[\033[0m\]" "\\\$ "'

# Git completion
# TODO: Add bash-completion for ubuntu, wsl.
#. ~/config/git-completion.bash

# CMake
alias build='(cd build && make -j8)'

test -r .dircolors && eval "$(dircolors .dircolors)"
if [[ `uname` == 'Linux' ]]; then
  alias mapmediakeys='xmodmap ~/config/mediakeys.xmodmap'
else
  alias mapmediakeys=':'
fi

# Load per-machine (or otherwise not in git) files.
if [ -a ~/config/env-more.sh ]; then
    . ~/config/env-more.sh
fi
