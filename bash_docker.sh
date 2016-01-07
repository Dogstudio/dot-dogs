#!/bin/bash
export DOCKER_PREFIX="\033[4mDOCKER\033[0m -"
export DOCKER_RED="\033[0;31m"
export DOCKER_GREEN="\033[0;32m"
export DOCKER_BLUE="\033[1;34m"
export DOCKER_NONE="\033[0m"

if [ -e "$(which docker-machine)" ]; then	

    function _dockerMachineName()
    {
        DOCKER_MACHINE_NAME="${1:-$DOCKER_MACHINE_NAME}"
        export DOCKER_MACHINE_NAME="${DOCKER_MACHINE_NAME:-$(docker-machine ls -q | head -n 1)}"
    }

    # -------------------------------------------------------------------------

    function _dockerAlias()
    {
        alias doup="docker-compose build --no-cache && docker-compose up -d"
        alias dodown="docker-compose stop"
        alias dologs="docker-compose logs"
    }
    
    # -------------------------------------------------------------------------

    function _dockerInit()
    {
        _dockerMachineName $1

        if [ "Running" != $(docker-machine status ${DOCKER_MACHINE_NAME}) ]; then
            echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_RED}not running${DOCKER_NONE}\n"
            return 1
        fi
  
        eval $(docker-machine env $DOCKER_MACHINE_NAME) && 
        echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_GREEN}running${DOCKER_NONE} with IP : $(docker-machine ip ${DOCKER_MACHINE_NAME})\n"

        _dockerAlias
    }

    # -------------------------------------------------------------------------

    function dostart()
    {
        _dockerMachineName $1

        if [ "Running" = $(docker-machine status ${DOCKER_MACHINE_NAME}) ]; then
            echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_GREEN}already running${DOCKER_NONE}  with IP : $(docker-machine ip ${DOCKER_MACHINE_NAME})\n"
            return 1
        fi
      
        docker-machine start ${DOCKER_MACHINE_NAME}

        until $(docker-machine env ${DOCKER_MACHINE_NAME} >/dev/null 2>&1); do
            echo "." ; sleep 1
        done
        
        eval "$(docker-machine env ${DOCKER_MACHINE_NAME})"
        echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_GREEN}started${DOCKER_NONE} with IP : $(docker-machine ip ${DOCKER_MACHINE_NAME})\n"
    }

    # -------------------------------------------------------------------------

    function dostop()
    {
        _dockerMachineName $1

        if [ "Running" != $(docker-machine status ${DOCKER_MACHINE_NAME}) ]; then
            echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_GREEN}already stopped${DOCKER_NONE}\n"
            return 1
        fi

        docker-machine stop ${DOCKER_MACHINE_NAME}

        until ! $(docker-machine env ${DOCKER_MACHINE_NAME} >/dev/null 2>&1) ; do
            echo "." ; sleep 1
        done

        echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_GREEN}stopped${DOCKER_NONE}, now\n"
    }

    # -------------------------------------------------------------------------

    function doconnect()
    {
        _dockerMachineName $1

        if [ "Running" = $(docker-machine status ${DOCKER_MACHINE_NAME}) ]; then
            if $(docker-machine env ${DOCKER_MACHINE_NAME} >/dev/null 2>&1) ; then
                eval "$(docker-machine env ${DOCKER_MACHINE_NAME})"
                echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_GREEN}connected${DOCKER_NONE} with IP : $(docker-machine ip ${DOCKER_MACHINE_NAME})\n"

                _dockerAlias
            else
                echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_RED}disconnected${DOCKER_NONE}\n"
            fi
        else
            echo -e "${DOCKER_PREFIX} Machine ${DOCKER_MACHINE_NAME} is ${DOCKER_RED}stopped${DOCKER_NONE}\n"
        fi
    }

    # -------------------------------------------------------------------------

    function dohelp()
    {
        echo -e "${DOCKER_PREFIX} Helper Commands.\n"
        echo -e "  ${DOCKER_BLUE}dostart${DOCKER_NONE} : Detect and start a Docker VM."
        echo -e "  ${DOCKER_BLUE}dostop${DOCKER_NONE} : Stop the connected Docker VM."
        echo -e "  ${DOCKER_BLUE}doconnect${DOCKER_NONE} : Set Docker environnement for your shell."
        echo -e "  ${DOCKER_BLUE}doup${DOCKER_NONE} : Build and Up the current Docker compose."
        echo -e "  ${DOCKER_BLUE}dodown${DOCKER_NONE} : Down the current Docker compose."
        echo -e "  ${DOCKER_BLUE}dologs${DOCKER_NONE} : Start the Logging system for the current Docker compose."
    }

    # -------------------------------------------------------------------------

    _dockerInit
fi