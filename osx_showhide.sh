#!/bin/bash
#
#   OSX - Toggle Hidden file visibility
#
function showhide()
{
    [[ $(defaults read com.apple.finder AppleShowAllFiles) == "1" ]] && STATE=0 || STATE=1
    defaults write com.apple.finder AppleShowAllFiles $STATE && killall Finder
}