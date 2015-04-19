#!/usr/bin/env bash
#
#   Bash Prompt With GIT
#
#   Editor: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------


RED="\[\033[0;31m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function getGitRepository {
    IS_GIT=`git branch > /dev/null 2>&1`

    if (( $? > 0 )); then
        BRANCH=''
    else
        getGitBranch
    fi
}

# Determine the branch/state information for this git repository.
function getGitBranch {
    # Capture the output of the "git status" command.
    git_status="$(git status 2> /dev/null)"

    # Set color based on clean/staged/dirty.
    if [[ ${git_status} =~ "working directory clean" ]]; then
        state="${GREEN}"
    elif [[ ${git_status} =~ "Changes to be committed" ]]; then
        state="${YELLOW}"
    else
        state="${LIGHT_RED}"
    fi

    # Set arrow icon based on status against remote.
    remote_pattern="# Your branch is (.*) of"
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
            remote="↑"
        else
            remote="↓"
        fi
    else
        remote=""
    fi
    diverge_pattern="# Your branch and (.*) have diverged"
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="↕"
    fi

    # Get the name of the branch.
    branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')

    # Set the final branch string.
    BRANCH="${state} (${branch})${remote} "
}

# Get color for user or Root
function setUserColor {
    USERID=`id -u`
    if (( 0 == "$(id -u)" )); then
        USER="${LIGHT_RED}"

    elif [[ "$(logname 2>/dev/null)" != "$(id -u -n)" ]]; then
        USER="${LIGHT_GRAY}"

    else
        USER="${BLUE}"
    fi
}

# What kind of session we use ? Local, Telnet, SSH
function setConnection {
    if [[ -n "$SSH_CLIENT$SSH2_CLIENT" ]] ; then
        SESSION="\u@\h (ssh) "
    else
        local SESSION_SRC=$(who am i | sed -n 's/.*(\(.*\))/\1/p')
        if [[ -z "$SESSION_SRC" || "$SESSION_SRC" = ":"* ]] ; then
            SESSION="Local "
        else
            SESSION="\u@\h $ "
        fi
    fi
}

# Set the definitive Bash Prompt
function setBashPrompt {
    getGitRepository
    setUserColor
    setConnection

    PS1="\n${USER}${SESSION}${COLOR_NONE}\w${BRANCH}${COLOR_NONE}\n➜ "
}

PROMPT_COMMAND=setBashPrompt
