#!/bin/bash

DOCKER_MACHINE_NAME="" # Leave blanck to autoselect.

if [ -e "$(which docker-machine)" ]; then
	
	if [ -z "$DOCKER_MACHINE_NAME" ]; then
		DOCKER_MACHINE_NAME=$(docker-machine ls --filter "state=Running" -q | head -n 1)
	fi

	eval $(docker-machine env $DOCKER_MACHINE_NAME)
fi
