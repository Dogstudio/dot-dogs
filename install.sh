#!/usr/bin/env bash
#
#   Installer for "Dog Shell Scripts"
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------

# Get current script
SCRIPT_URL="https://repositories.dogstudio.be/devtools/terminaldog/raw/master/install.sh"
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd -P)
SCRIPT_PROFILE="$HOME/.bashrc"

echo -e "Installing Dogshell"

# Install from remote 
if [[ $(basename $0) != "install.sh" ]]; then
    echo -e "\tDownloading"
    git archive --remote $SCRIPT_URL master | tar -x -C ./ && bash install.sh

# Install localy
else
    # Add to profile
    for FILE in $HOME/.profile $HOME/.bash_profile $HOME/.bashrc; do
        if [[ -f $FILE ]]; then
            if [[ $(grep -s "$SOTE_PATH" $FILE) ]]; then
                unset FILE; break
            fi
        fi
    done

    for FILE in $(ls *.sh | grep -v "install"); do
        if [[ $(grep -s "$SCRIPT_PATH/$FILE" $SCRIPT_PROFILE) ]]; then
            echo -e "\tScript $FILE already installed."
        else
            echo -e "\tAdd $FILE to .bashrc"
            echo "source $SCRIPT_PATH/$FILE" >> $SCRIPT_PROFILE
        fi
    done
fi