#!/bin/bash
#
#   Docker aliases and commands
#
#   Add this script to your ".(ba|z)shrc" to add userfriendly aliases
#
# -------------------------------------------------------------------------------------------------
export DOCKER_PREFIX="\033[4mDOCKER\033[0m -"
export DOCKER_MACHINE_NAME=""
export DOCKER_MACHINE_IP=""

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[1;33m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\033[1;34m"
COLOR_LIGHT_RED="\033[1;31m"
COLOR_LIGHT_GREEN="\033[1;32m"
COLOR_WHITE="\033[1;37m"
COLOR_LIGHT_GRAY="\033[0;37m"
COLOR_NONE="\033[0m"

# -------------------------------------------------------------------------------------------------
# Validation
if [ -z "$(command -v docker)" ]; then
    echo -e "${DOCKER_PREFIX} command \"docker\" ${COLOR_RED}not installed${COLOR_NONE}. Abording.\n"
fi

# -------------------------------------------------------------------------------------------------
# Auto installation

DOCKER_PATH="$HOME/.sctipts"
DOCKER_SCRIPT="docker_commands.sh"
DOCKER_URL="https://raw.githubusercontent.com/Dogstudio/docker-dogs/master/scripts/${DOCKER_SCRIPT}"

[ "$(basename -- $0)" != "$(basename ${DOCKER_SCRIPT})" ] && [ -z "${BASH_SOURCE[0]}" ] && (
    # If ROOT, install globally
    [ "$(id -u)" == "0" ] && DOCKER_PATH="/usr/local/bin"

    # Install the file
    [ -d "$DOCKER_PATH" ] || mkdir -p ${DOCKER_PATH}
    curl -sS -o ${DOCKER_PATH}/${DOCKER_SCRIPT} ${DOCKER_URL}

    # Add the script in your .(ba|z)shr
    if [ -e "${DOCKER_PATH}/${DOCKER_SCRIPT}" ]; then
        [ -e "$HOME/.bashrc" ] && \
        grep -Fq "${DOCKER_PATH}/${DOCKER_SCRIPT}" "$HOME/.bashrc" || \
        echo "source ${DOCKER_PATH}/${DOCKER_SCRIPT}" >> $HOME/.bashrc

        [ -e "$HOME/.zshrc" ] && \
        grep -Fq "${DOCKER_PATH}/${DOCKER_SCRIPT}" "$HOME/.zshrc" || \
        echo "source ${DOCKER_PATH}/${DOCKER_SCRIPT}" >> $HOME/.zshrc
    fi

    echo -e "${DOCKER_PREFIX} Commands installed ${COLOR_GREEN}successfully${COLOR_NONE}\n"
)

# =================================================================================================

#
#  (try to) Initialize environment with the current running Docker (machine)
#
function _dockerInit()
{
    # Docker Machine 
    if [ -n "$(docker-machine status | grep -i 'run')" ]; then
        DOCKER_MACHINE_NAME=$(docker-machine ls -q --filter "state=Running")
        
        if ! DOCKER_MACHINE_IP=$(docker-machine ip $DOCKER_MACHINE_NAME 2>/dev/null); then 
            echo -e "${DOCKER_PREFIX} The \"${DOCKER_MACHINE_NAME}\" ${COLOR_RED}has no IP${COLOR_NONE}"; return 1
        fi

        if ! docker-machine env 2>&1 >/dev/null; then 
            docker-machine regenerate-certs -f ${DOCKER_MACHINE_NAME}
        fi

        if ! docker-machine env 2>&1 >/dev/null; then 
            echo -e "${DOCKER_PREFIX} The \"${DOCKER_MACHINE_NAME}\" ${COLOR_RED}has no ENV${COLOR_NONE}"; return 1
        fi

        eval $(docker-machine env)
        echo -e "${DOCKER_PREFIX} Machine \"${DOCKER_MACHINE_NAME}\" is ${COLOR_GREEN}running${COLOR_NONE} with IP : ${DOCKER_MACHINE_IP}"

    # Local Deamon (Docker for Mac)
    elif docker info 2>/dev/null >/dev/null ; then
        DOCKER_MACHINE_NAME=$(docker info 2>/dev/null | awk -F':' '/Name/ {print $2}' | tr -d ' ')
        DOCKER_MACHINE_IP="127.0.0.1"
        
        echo -e "${DOCKER_PREFIX} Local Docker deamon is ${COLOR_GREEN}running${COLOR_NONE}."
    
    # None is running
    else
        unset DOCKER_TLS_VERIFY
        unset DOCKER_CERT_PATH
        unset DOCKER_MACHINE_NAME
        unset DOCKER_HOST
        
        echo -e "${DOCKER_PREFIX} Docker ${COLOR_RED} is not running${COLOR_NONE}"; return 1
    fi

    export DOCKER_MACHINE_NAME
    export DOCKER_MACHINE_IP
}

#
# Initialize the terminal Session
#
function _dockerSessionInit() 
{
    _dockerGenericAlias
    _dockerInit
    _dockerAlias
    _dockerCompleter
    _updateDnsMask
}

#
# Create Aliases for common use
#
function _dockerGenericAlias()
{
    alias doma="docker-machine"
    alias doco="docker-compose"
}

#
# Create alias for daily use commands
#
function _dockerAlias()
{
    alias doup="docker-compose build && docker-compose up -d --remove-orphans"
    alias dodown="docker-compose stop"
    alias doreload="dodown && doup"
    alias dologs="docker-compose logs"
    alias doall="docker-compose down && docker-compose rm && docker-compose build --no-cache --force-rm && docker-compose up -d"
    alias doinit="_dockerInit"
}

#
#   Autocompleter
#
function _dockerCompleter()
{
    if $(type complete >/dev/null); then
        
        # Search for Container
        function _completeContainer()
        {
            local word="${COMP_WORDS[COMP_CWORD]}"
            COMPREPLY=( $(compgen -W "$(docker ps --filter "status=running" --format "{{.Names}}")" -- "$word") )
        }
        complete -F _completeContainer doshell

        # Search for Services
        function _completeServices()
        {
            local word="${COMP_WORDS[COMP_CWORD]}"
            COMPREPLY=( $(compgen -W "$(docker ps --filter "status=running" --format "{{.Names}}" | cut -d'_' -f 2)" -- "$word") )
        }
        complete -F _completeServices dologs

        # Docker machine
        if [ -n "$(command -v docker-machine)" ]; then
            function _completeDockerMachine()
            {
                local cmd="${1##*/}"
                local word="${COMP_WORDS[COMP_CWORD]}"

                case "$cmd" in
                    dostart)
                        COMPREPLY=( $(compgen -W "$(docker-machine ls -q --filter "state=Stopped")" -- "$word") )
                        ;;
                    dostop)
                        COMPREPLY=( $(compgen -W "$(docker-machine ls -q --filter "state=Running")" -- "$word") )
                        ;;
                    *)
                        COMPREPLY=( $(compgen -W "active config create env inspect ip kill ls provision restart rm ssh scp start status stop upgrade url version help regenerate-certs" -- "$word") )
                        ;;
                esac
            }
            complete -d -f -W "build bundle config create down events exec help kill logs pause port ps pull push restart rm run scale start stop unpause up version" doma
            complete -d -f -F _completeDockerMachine docker-machine
            complete -F _completeDockerMachine dostart 
            complete -F _completeDockerMachine dostop 
        fi

        # Other commands
        local COMPLETE_DOCO="build bundle config create down events exec help kill logs pause port ps pull push restart rm run scale start stop unpause up version"
        complete -W "$COMPLETE_DOCO" docker-compose
        complete -W "$COMPLETE_DOCO" doco

        complete -W "doma doco dostop dostart dohelp dologs" dohelp
    fi
}

#
# Update and restart dnsmasq (if present) with the current IP
#
function _updateDnsMask()
{
    DNSMASQ_CONF="$(brew --prefix)/etc/dnsmasq.conf"
    
    if [ -f ${DNSMASQ_CONF} ]; then
        if ! grep "${DOCKER_MACHINE_IP}" ${DNSMASQ_CONF} >/dev/null ; then
            echo -e "${DOCKER_PREFIX} I need ${COLOR_RED}update dnsmasq to match IP to \"${DOCKER_MACHINE_IP}\"${COLOR_NONE}."
            sed -i -e "s|dok/[0-9.]*$|dok/${DOCKER_MACHINE_IP}|" ${DNSMASQ_CONF}

            sudo launchctl stop homebrew.mxcl.dnsmasq &&
            sudo killall -HUP mDNSResponder &&
            sudo launchctl start homebrew.mxcl.dnsmasq
        fi
    fi
}

# -------------------------------------------------------------------------------------------------

# Start a machine
function dostart()
{
    docker-machine start $1 && _dockerInit && _updateDnsMask
}

# Stop a machine
function dostop()
{
    docker-machine stop $1 && \
    unset DOCKER_TLS_VERIFY && \
    unset DOCKER_CERT_PATH && \
    unset DOCKER_MACHINE_NAME && \
    unset DOCKER_HOST && \
    _dockerInit
}


# Run a shell on the specified container
function doshell()
{
    docker exec -t -i $1 /bin/bash
}

function dohelp()
{
    case "$1" in
        doma)
            echo -e "${DOCKER_PREFIX} Help for command ${COLOR_WHITE}doma${COLOR_NONE}."
            echo ''
            echo -e "${COLOR_WHITE}doma${COLOR_NONE} is simple alias for docker-machine."
            echo -e "You can use completion to get sub command of docker-machine."
        ;;
        doco)
            echo -e "${DOCKER_PREFIX} Help for command ${COLOR_WHITE}doco${COLOR_NONE}."
            echo ''
            echo -e "${COLOR_WHITE}doco${COLOR_NONE} is simple alias for docker-compose."
            echo -e "You can use completion to get sub command of docker-machine."
        ;;
        dostop)
            echo -e "${DOCKER_PREFIX} Help for command ${COLOR_WHITE}dostop${COLOR_NONE}."
            echo ''
            echo -e "${COLOR_WHITE}dostop${COLOR_NONE} is used to stop the running machine."
            echo -e "You can use completion to get the running machine name."
        ;;
        dostart)
            echo -e "${DOCKER_PREFIX} Help for command ${COLOR_WHITE}dostart${COLOR_NONE}."
            echo ''
            echo -e "${COLOR_WHITE}dostart${COLOR_NONE} can start a non-running machine and set the environment."
            echo -e "You can use completion to get the startable machine."
        ;;
        dologs)
            echo -e "${DOCKER_PREFIX} Help for command ${COLOR_WHITE}dologs${COLOR_NONE}."
            echo ''
            echo -e "${COLOR_WHITE}dologs${COLOR_NONE} start the Logging system for the current Docker compose."
            echo -e "You can use completion to limit the logs to one of the current running services."
        ;;
        *)
            echo -e "${DOCKER_PREFIX} Helper Commands."
            echo ''
            echo -e "  ${COLOR_WHITE}doma${COLOR_NONE}:     Simple alias for docker-machine."
            echo -e "  ${COLOR_WHITE}doco${COLOR_NONE}:     Simple alias for docker-compose."
            echo -e "  ${COLOR_WHITE}doinit${COLOR_NONE}:   Initialize the session according the Docker ENV."
            echo ''
            echo -e "  ${COLOR_BLUE}doup${COLOR_NONE}:     Build and Up the current Docker compose."
            echo -e "  ${COLOR_BLUE}dodown${COLOR_NONE}:   Down the current Docker compose."
            echo -e "  ${COLOR_BLUE}doreload${COLOR_NONE}: Down and up the current Docker compose."
            echo -e "  ${COLOR_BLUE}doshell${COLOR_NONE}:  Open shell on specified container (autocomplete)."
            echo -e "  ${COLOR_BLUE}dologs${COLOR_NONE}:   Start the Logging system for the current Docker compose."
            ;;
    esac
}

# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Init
_dockerSessionInit
