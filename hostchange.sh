#!/bin/bash
#
# Update the machine name
#
clear
echo -e "I'll update your MAC configuration to set your Dogname as Computer...\n"

read -p "What's your dogname: " DOG;
NEWDOG=`php -r "echo ucfirst(strtolower('$DOG'));"`

sudo -p "Now, enter your connection password (it will not sent or copied, I promise): " scutil --set ComputerName "$NEWDOG" && sudo scutil --set LocalHostName "$NEWDOG" && sudo scutil --set HostName "$NEWDOG" &&\
echo -e "\Done. You can quit the Terminal, now." || echo -e "\nOups, something went Wrong..."
