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
alias wget="wget -c"

alias mkdir="mkdir -p"
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias phpserv='php -S 0.0.0.0:8080 -t ./'

# -----------------------------------------------------------------------------

# Where my site is hosted ?
function hosted() {
    dig +short -x $(dig +short $1)
}
