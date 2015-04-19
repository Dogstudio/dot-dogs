#!/usr/bin/env bash
#
#   Open (file|dir|project) in Sublime
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------

if [[ -z $(which subl) ]]; then 

    #
    #   Add autodetection on Sublimetext opener
    #
    function openSublime() {
        SUBL_FILE=$@
        SUBL_CMD='/usr/local/bin/subl'

        # Only one argument...
        if (( $# > 1 )); then 

            # Is Directory...
            if [ -d "${SUBL_FILE}" ]; then
                
                # ...whitout "Project"
                SUB_PROJECT=$(ls *.sublime-project 2>/dev/null)
                [ -z "${SUB_PROJECT}" ] && { $SUBL_CMD -n ${SUBL_FILE}; exit 0; }
                
                # ...with "Project"
                SUBL_FILE="${SUBL_FILE}/${SUB_PROJECT}"
            fi

            # Is Project... 
            [ "${SUBL_FILE}" == *".sublime-project" ] && { $SUBL_CMD -n --project ${SUBL_FILE}; exit 0; }

        fi

        # ... or a Simple file
        $SUBL_CMD ${SUBL_FILE}
    }

    #
    #   Alias
    #
    alias subl='openSublime'
fi

export EDITOR='/usr/local/bin/subl -w'