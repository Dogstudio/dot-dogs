#!/usr/bin/env bash
EXTRA_SCRIPT_FOLDER=$(dirname "${BASH_SOURCE[0]}")

source ${EXTRA_SCRIPT_FOLDER}/prompt.sh
source ${EXTRA_SCRIPT_FOLDER}/aliases.sh
source ${EXTRA_SCRIPT_FOLDER}/ssh.sh

source ${EXTRA_SCRIPT_FOLDER}/applications.sh
source ${EXTRA_SCRIPT_FOLDER}/osx.sh
source ${EXTRA_SCRIPT_FOLDER}/vagrant.sh
source ${EXTRA_SCRIPT_FOLDER}/docker.sh
