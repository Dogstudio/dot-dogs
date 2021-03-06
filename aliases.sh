#!/usr/bin/env bash
#
#   Aliases for generic commands
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------

# I need colors !!!
alias ls='ls -G'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias l='clear; ls -lAh'
alias duh='du -hs'
alias tree="find . | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"
alias lssh='egrep "Host\ .*" ~/.ssh/config | cut -f2 -d " "'
alias wget="wget -c"

alias mkdir="mkdir -p"
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias phpserv='php -S 0.0.0.0:8080 -t ./'

# GIT
alias gad='git add'
alias gco='git checkout'
alias gcm='git commit'
alias gpl='git pull'
alias gps='git push'
alias glo='git log'
alias gst='git status'

# Bark
alias bark='barkgo'
alias brk='barkgo'
alias b='barkgo'

# -----------------------------------------------------------------------------

# Where my site is hosted ?
function hostedon() {
    IP_LIST=$(dig +short $1) ; 
    [ -n "$IP_LIST" ] && dig +short -x $IP_LIST || echo 'Not found'
}
