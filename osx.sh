#!/bin/bash
#
#   Tools and functions for OSX Application
#

# Copy current path in the clipboard
function copypath() {
    echo "$(pwd)/" | pbcopy
}
alias cpath='copypath'
alias cpt='copypath'


#  GNU command for OSX (via Homebrew) : brew install coreutils
if [[ -d "/usr/local/opt/coreutils/" ]]; then
    #export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    #export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    alias ls='gls --color --group-directories-first'
fi


# Toggle display of hidden files
function showhide()
{
    [[ $(defaults read com.apple.finder AppleShowAllFiles) == "1" ]] && STATE=0 || STATE=1
    defaults write com.apple.finder AppleShowAllFiles $STATE && killall Finder
}
