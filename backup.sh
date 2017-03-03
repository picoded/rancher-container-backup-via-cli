#!/bin/bash

# Get the current working directory
WORKDIR="`dirname \"$0\"`"
cd "${WORKDIR}" || exit 1

# Runs the respective rancher command in mac, or linux shell
./core/run-script.sh backup "$@"