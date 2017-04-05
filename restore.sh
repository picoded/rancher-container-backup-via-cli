#!/bin/bash

# Example call
# ./restore.sh mysql stack-path/mysql-1

# Get the current working directory
WORKDIR="`dirname \"$0\"`"
cd "${WORKDIR}" || exit 1

# Runs the respective rancher command in mac, or linux shell
./core/run-script.sh restore "$@"