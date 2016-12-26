#!/bin/bash

##############################################################################
#
#  Runs the built backup script with the following format on rancher
#
#  ./run-rancher.sh  (backup/restore) (stack-container-id)
#
##############################################################################

# Get the current working directory
WORKDIR="`dirname \"$0\"`"
cd "${WORKDIR}" || exit 1

# Run the built rancher script
./bin/RancherExec.sh $1 $2
