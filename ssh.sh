#!/usr/bin/env bash
#
#   Autocompletor for SSH Hosts Connexion
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------

#
#   Complete connexion name based on SSH config
#
if [[ -n $(type -t complete) ]]; then
    ssh_complete() {
        local word="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "$(awk '/^Host/{for(i=1;++i <= NF;) print $i}' ~/.ssh/config)" -- "$word") )
    }

    complete -F ssh_complete ssh
    #complete -F ssh_complete scp
fi
