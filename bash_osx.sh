#!/usr/bin/env bash
#
#   GNU command for OSX (via Homebrew)
#
#   Install: brew install coreutils
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: May 2015
#
# -----------------------------------------------------------------------------

if [[ -d "/usr/local/opt/coreutils/" ]]; then
    #export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    #export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

    alias ls='gls --color --group-directories-first'
fi