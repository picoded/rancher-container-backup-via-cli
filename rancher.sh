#!/bin/bash

##############################################################################
#
#  Runs the rancher script, cross platform, with configurable config
#
#  ./rancher.sh  [additional-commands] ...
#
##############################################################################

# Get the current working directory
WORKDIR="`dirname \"$0\"`"
cd "${WORKDIR}" || exit 1
WORKDIR="$(pwd)";

# Include the config file
source ./config/rancher-config.sh;

# Runs the respective rancher command in mac, or linux shell
# Because it does not come packaged together =(
if [ "$(uname)" == "Darwin" ]; then
	./rancher-bin/rancher-osx "$@"
else
	./rancher-bin/rancher "$@"
fi
