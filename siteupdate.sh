#!/bin/bash
#
#   Function to update current site with GIT
#
# -----------------------------------------------------------------------------

function site-update {
    GIT_BRANCH=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    GIT_REMOTE=$(git remote)

    if [[ -n "${GIT_BRANCH}" && -n "${GIT_REMOTE}" ]]; then
        git pull --ff-only $GIT_REMOTE $GIT_BRANCH
    else
        echo "Not git directory"
    fi
}
alias siteupdate='site-update'

alias update-production='echo "Obsolete ! Use \"site-update\" instead."'
alias update-site='echo "Obsolete ! Use \"site-update\" instead."'
alias update-stage='echo "Obsolete ! Use \"site-update\" instead."'
alias update-staging='echo "Obsolete ! Use \"site-update\" instead."'