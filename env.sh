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
PATH=${BASE_PATH:+${BASE_PATH}:}$HOME/bin

if [ -z ${USERNAME+x} ]; then
    export USERNAME=$USER
fi

# basic aliases
if [[ `uname` == 'Darwin' ]]; then
  alias ll='ls -alGF'
  alias la='ls -AGF'
  alias l='ls -CGF'
else
  alias ls='ls --color=auto'
  alias ll='ls -alFv --color=auto'
  alias la='ls -AF --color=auto'
  alias l='ls -CF --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
alias tidy='rm -f *~ .*~'

# gsync: syncs from origin, updates local master, and rebases current branch.
# GIT_PARENTS is used for branches that aren't based on the main branch.
# TODO: This behavior is kinda weird and probably a bit nonsensical, fix it the next time
# you try to use it.
unset GIT_PARENTS
if (( BASH_VERSINFO[0] > 3 )); then
  declare -A GIT_PARENTS
fi

alias gitmainbranch="git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"

gup() {
  git rev-parse --verify develop &> /dev/null
  mainBranch=$(gitmainbranch)
  git update origin
  git rebase origin/$mainBranch $mainBranch
}

gsync() {
  currentBranch=`git rev-parse --abbrev-ref HEAD`
  mainBranch=$(gitmainbranch)
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

# Git prompt: defaults are blue hostname. WSL uses this as-is; Macbook changes hostname; remote
# hosts set red prompt and might override name.
PROMPT_HOST=$(hostname)
if [[ "$(uname)" == "Darwin" ]]; then
  # Macbook doesn't want to use whatever random hostname it has.
  PROMPT_HOST="macbook"
fi

if [ -z ${ZSH_NAME+x} ]; then
  . ~/config/git-prompt.sh
  GIT_PS1_DESCRIBE_STYLE='describe'
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWCOLORHINTS=1
  PROMPT_BODY='\[\033[34m\]\u@${PROMPT_HOST}\[\033[0m\]:\[\033[35m\]\w\[\033[0m\]'
  GIT_PROMPT_COMMAND='__git_ps1 "$PROMPT_BODY" "\\\$ "'
  UNGIT_PROMPT="${PROMPT_BODY}\$ "
  export PROMPT_COMMAND=$GIT_PROMPT_COMMAND
else
  autoload -Uz add-zsh-hook vcs_info
  setopt prompt_subst
  add-zsh-hook precmd vcs_info
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' unstagedstr ' %F{red}*%f'
  zstyle ':vcs_info:*' stagedstr ' %F{green}+%f'
  zstyle ':vcs_info:git:*' formats       ' (%F{green}%b%f%u%c)'
  zstyle ':vcs_info:git:*' actionformats ' (%b|%a%u%c)'

  PROMPT='%F{blue}%n@${PROMPT_HOST}%f:%F{magenta}%~%f${vcs_info_msg_0_}%# '
fi

test -r .dircolors && eval "$(dircolors .dircolors)"

alias rmtmp='rm -rf ~/tmp/*'

alias scp='scp -A'
alias ssh='ssh -A'

alias wipe='clear && history -p'
alias cls='clear && history -p'

# Go stuff
if command -v go &> /dev/null; then
  export GOPATH=$HOME/go
  export GOBIN=$HOME/go/bin
  PATH=$PATH:$GOBIN:$GOPATH
  alias gorun='go run main.go'
fi

# Load per-machine (or otherwise not in git) files.
if [ -e $ENV_MORE_FILE ]; then
  . $ENV_MORE_FILE
fi
