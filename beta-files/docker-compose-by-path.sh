#!/bin/bash

ALL_PARAMS="${@:1}" #except the scritt name
PARAMS_TO_DC="${@:2}"
SHOW_COMMAND=0 ## Output the final command
SCRIPT_NAME=$(basename "$0")

$(which docker-compose 2>&1 > /dev/null)
if [ $? -ne 0 ]; then
    echo "docker-compose not found. Please install docker-compose."
    exit 1
fi

DOCKER_COMPOSE_BIN=$(which docker-compose)

help()
{
    echo -e "\n"
    echo -e "Usage:\n"
    echo " $SCRIPT_NAME <project-directory>"
    echo " $SCRIPT_NAME <project-directory> --show-command  #=> Show the final command"
    echo " $SCRIPT_NAME --help                              #=> Show this help"
    echo -e "\n"
}

if [ -z $1 ]; then
    help
    exit 1
fi

if [[ "${ALL_PARAMS}" == *"--help"* ]]; then
    help
    exit 0
fi

if [[ "${ALL_PARAMS}" == *"--show-command"* ]]; then
    SHOW_COMMAND=1
    PARAMS_TO_DC=${PARAMS_TO_DC//--show-command/}
fi

PROJECT_DIRECTORY="$1"

if [ ! -d "${PROJECT_DIRECTORY}" ]; then
    echo "Project directory '${PROJECT_DIRECTORY}' does not exist."
    exit 1
fi

DOCKER_COMPOSE_FILE="docker-compose.yml"
DOCKER_COMPOSE_FILE_PATH="${PROJECT_DIRECTORY}/${DOCKER_COMPOSE_FILE}"

COMMAND="${DOCKER_COMPOSE_BIN} --project-directory '${PROJECT_DIRECTORY}' -f '${DOCKER_COMPOSE_FILE_PATH}' ${PARAMS_TO_DC}"

if [ ${SHOW_COMMAND} -eq 1 ]; then
    echo -e "\nRunning:\n${COMMAND}\n"
fi

bash -c "${COMMAND}"
