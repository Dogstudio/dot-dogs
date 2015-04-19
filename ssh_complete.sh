#!/usr/bin/env bash
#
#   Autocompletor for SSH Hosts Connexion
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------

if [[ -n $(type -t complete) ]]; then
    
    #
    #   Complete connexion name based on SSH config
    #
    _complete() {
        local word="${COMP_WORDS[COMP_CWORD]}"

        COMPREPLY=( $(compgen -W "$(egrep 'Host\ .*' ~/.ssh/config | cut -f2 -d ' ')" -- "$word") )
    }

    complete -F _complete ssh
fi