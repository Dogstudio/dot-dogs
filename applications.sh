#!/usr/bin/env bash
#
#   Application shortcuts and extras
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2016
#
# -----------------------------------------------------------------------------

# SUBLIME TEXT - Open (file|dir|project) in Sublime
if [[ -n $(which subl) ]]; then 

    function openSublime() {
        SUBL_FILE=$@
        SUBL_CMD=$(which subl)

        # No argument...
        if (( $# < 1 )); then 
            SUB_PROJECT=$(ls *.sublime-project 2>/dev/null)
            [ -n "${SUB_PROJECT}" ] && SUBL_FILE="${SUB_PROJECT}"
        fi

        # Is Directory...
        if [ -d "${SUBL_FILE}" ]; then

            # ...whitout "Project"
            SUB_PROJECT=$(ls $SUBL_FILE*.sublime-project 2>/dev/null)
            [ -z "${SUB_PROJECT}" ] && { $SUBL_CMD -n ${SUBL_FILE}; return ; }
            
            # ...with "Project"
            SUBL_FILE="${SUB_PROJECT}"
        fi

        # Is Project... 
        [ "${SUBL_FILE}" == *".sublime-project" ] && { $SUBL_CMD -n --project ${SUBL_FILE}; return ; }

        # ... or multiple file
        $SUBL_CMD ${SUBL_FILE}
    }

    #
    #   Alias
    #
    alias subl='openSublime'
    export EDITOR='/usr/local/bin/subl -w'
fi

# -----------------------------------------------------------------------------

# PhpStorm
if [[ -n $(which pstorm) ]]; then 
    alias storm='pstorm ./'
fi

# -----------------------------------------------------------------------------

# Tower
if [[ -n $(which gittower) ]]; then 
    function tower() {
        gittower ${1:-./}    
    }

    alias twr='tower'
fi


# -----------------------------------------------------------------------------

# Dash Opener
if [ -d "/Applications/Dash.app/" ]; then 
    function openDash() {
        open dash://$1
    }
    alias dash='openDash'
fi
