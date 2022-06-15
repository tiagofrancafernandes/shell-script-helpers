#!/bin/bash

BIN_NAME=$(basename "${0}")
FINAL_FILE="$1"
RUN_TIME=$(date +%Y-%m-%d\ %H:%M:%S)

if [[ -p /dev/stdin ]]
    then
    CONTENT="$(cat -)"  ##Get value sended via pipe
else
    CONTENT="${2}";
fi

help()
{
    echo -e "\n\tHow to use:\n"
    echo -e "\t${BIN_NAME} --help -------------------------------------- Help\n"
    echo -e "\t${BIN_NAME} \"/path/to/my/file.txt\" \"content\" ------------ Log to file\n"
    echo -e "\techo \"content\" | ${BIN_NAME} \"/path/to/my/file.txt\" ----- Log to file using pipe value\n"
}

if [ "${1}" = '--help' ]; then
    help
    exit 0;
fi

if [ -z "${1}" ]; then
    echo -e "\n\tERROR: Please enter a destination file.\n"
    help
    exit 2;
fi

TEMP_OUTPUT_FILE="$(mktemp /tmp/log-output-to.XXXXXXXX).log"

DIR_TO_SAVE_LOG=$(dirname "${FINAL_FILE}")

if [ ! -d "${DIR_TO_SAVE_LOG}" ]; then
    mkdir -p "${DIR_TO_SAVE_LOG}"
fi

if [ ! -d "${DIR_TO_SAVE_LOG}" ]; then
    echo -e "The dir '${DIR_TO_SAVE_LOG}' dont exists"
    exit 1
fi

echo -e "[${RUN_TIME}]\n${CONTENT}\n" > "${TEMP_OUTPUT_FILE}"

sudo cat "${TEMP_OUTPUT_FILE}" >> "${FINAL_FILE}"
