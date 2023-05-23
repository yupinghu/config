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


# History
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE="${HOME}/.zsh_history"
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
alias h='history -E -100'

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
  if [[ $mainBranch != $currentBranch ]]; then
    echo "* Rebasing $currentBranch onto origin/$mainBranch"
    git rebase origin/$mainBranch $currentBranch
  fi
}

gcpt() {
  topCommit=`git rev-parse --verify $1`
  git branch -f $1 HEAD
  git co $1
  git cp $topCommit
}

# zsh completion
autoload -Uz compinit && compinit

# Prompt
PROMPT_HOST=$(hostname)
if [[ "$(uname)" == "Darwin" ]]; then
  # Macbook doesn't want to use whatever random hostname it has.
  PROMPT_HOST="macbook"
fi
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{red}*%f'
zstyle ':vcs_info:*' stagedstr ' %F{green}+%f'
zstyle ':vcs_info:git:*' formats       ' (%F{green}%b%f%u%c)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a%u%c)'
PROMPT='%F{blue}%n@${PROMPT_HOST}%f:%F{magenta}%~%f${vcs_info_msg_0_}%# '

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
