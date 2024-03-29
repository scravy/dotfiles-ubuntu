# apply for interactive shells only (do not fuck around with shell scripts)
case $- in
    *i*) ;;
      *) return;;
esac

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

alias ls='ls --color'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lAh'
alias llt='ls -lAhtr'
alias gls='git status'
alias gpsup="git push --set-upstream origin \`echo \$git_current_branch\`"
alias mysql='/usr/local/mysql/bin/mysql'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias s3='aws s3'

alias rdiff=$(which diff) # raw diff
alias rgrep=$(which grep) # raw grep
alias rless=$(which less) # raw less

alias grep='rgrep -I --color=always'
alias less='rless -R'
alias diff='rdiff --color=always'
alias jshell='docker run -it openjdk:10-slim /bin/jshell'

# do not put duplicate lines or lines starting with a space in the history
HISTCONTROL=ignoreboth

# append to history file - do not overwrite it
shopt -s histappend

# check window size and update LINES and COLUMNS after every command
shopt -s checkwinsize

# some color variables for convenience
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"

RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
CYAN="\[$(tput setaf 6)\]"
RESET="\[$(tput sgr0)\]"

# multiline prompt
__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1="`date +%H:%M:%S` "

    PS1+="\[\033[01;32m\]\u@`hostname`\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]"

    if [ $EXIT != 0 ]; then
        PS1+=" (${RED}${EXIT}${RESET})"
    else
        PS1+=" (${GREEN}${EXIT}${RESET})"
    fi

    PS1+=$'\n'
    PS1+="${CYAN}"
    PS1+='$'
    PS1+="${RESET} "
}

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command

alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

scala11() {
  sbt 'set scalaVersion := "2.11.11"' console
}

scala12() {
  sbt 'set scalaVersion := "2.12.2"' console
}

scala13() {
  sbt 'set scalaVersion := "2.13.0"' console
}

export AWS_ACCESS_KEY_ID=$(cat "$HOME/.aws/credentials" | head -n2 | tail -n1 | cut -d= -f2 | tr -d '[:space:]')
export AWS_SECRET_ACCESS_KEY=$(cat "$HOME/.aws/credentials" | tail -n1 | cut -d= -f2 | tr -d '[:space:]')

export PATH="$PATH:$HOME/.bin:$HOME/.local/bin"

source /usr/share/bash-completion/completions/git
