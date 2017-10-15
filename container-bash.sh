#!/bin/bash

# Opens an interactive bash terminal to the target container
#
# Example call
# ./container-bash.sh stack-path/mysql-1

# Get the current working directory
WORKDIR="`dirname \"$0\"`"
cd "${WORKDIR}" || exit 1

# Process the container name
TARGET_CONTAINER="$1"
TARGET_CONTAINER=$(echo $TARGET_CONTAINER | sed 's|/|-|g');

# Open the bash terminal to the respective container
./rancher.sh exec -it $TARGET_CONTAINER bash