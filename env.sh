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

# Git prompt: defaults are blue hostname. WSL uses this as-is; Macbook changes hostname; remote
# hosts set red prompt and might override name.
PROMPT_HOST=$(hostname)
PROMPT_HEADER_COLOR="34"
if [ "$(uname)" == "Darwin" ]; then
  # Macbook doesn't want to use whatever random hostname it has.
  PROMPT_HOST="macbook"
elif [[ ! -v WSL_DISTRO_NAME ]]; then
  # Non-WSL/Mac (i.e. remote) hosts get a red prompt.
  PROMPT_HEADER_COLOR="31"
  # Cloud instance doesn't want to use whatever random hostname it has.
  if hostname | grep -iq "cd.*cloud" ; then
    PROMPT_HOST="cloud"
  fi
fi
. ~/config/git-prompt.sh
GIT_PS1_DESCRIBE_STYLE='describe'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_BODY='\[\033[${PROMPT_HEADER_COLOR}m\]\u@${PROMPT_HOST}\[\033[0m\]:\[\033[35m\]\w\[\033[0m\]'
GIT_PROMPT_COMMAND='__git_ps1 "$PROMPT_BODY" "\\\$ "'
UNGIT_PROMPT="${PROMPT_BODY}\$ "
alias setgitprompt='export PROMPT_COMMAND=$GIT_PROMPT_COMMAND'
alias unsetgitprompt='unset PROMPT_COMMAND && PS1=$UNGIT_PROMPT'
# Default turn git prompt on.
setgitprompt

# Git completion
# TODO: Add bash-completion for ubuntu, wsl.
#. ~/config/git-completion.bash

# CMake
alias build='(cd build && make -j8)'

test -r .dircolors && eval "$(dircolors .dircolors)"
#if [[ `uname` == 'Linux' ]]; then
#  alias mapmediakeys='xmodmap ~/config/mediakeys.xmodmap'
#else
#  alias mapmediakeys=':'
#fi

# Load per-machine (or otherwise not in git) files.
if [ -a ~/config/env-more.sh ]; then
    . ~/config/env-more.sh
fi
