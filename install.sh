#!/usr/bin/env bash
#
#   Installer for "Dog Shell Scripts"
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------

# Get current script
SCRIPT_URL="git@gitlab.dogstudio.be:devtools/terminaldog.git"
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd -P)
SCRIPT_PROFILE="$HOME/.bashrc"

# Install from remote 
if [[ $(basename $0) != "install.sh" ]]; then
    echo -e "\tDownloading"
    git archive --remote $SCRIPT_URL master | tar -x -C ./ && bash install.sh

# Install localy
else
    # Test .bashrc is loaded
    if [[ -f "$HOME/.bash_profile" && $(grep -s ".bashrc" $HOME/.bash_profile) ]]; then
        echo "\tWARNING: .bashrc seems not included in .bash_profile"
    fi

    # Add scripts to "Bashrc"
    for FILE in $(ls *.sh | grep -v "install"); do
        if [[ $(grep -s "$SCRIPT_PATH/$FILE" $SCRIPT_PROFILE) ]]; then
            echo -e "\tScript $FILE already installed."
        else
            echo -e "\tAdd $FILE to $SCRIPT_PROFILE"
            echo "source $SCRIPT_PATH/$FILE" >> $SCRIPT_PROFILE
        fi
    done

    source $SCRIPT_PROFILE
fi