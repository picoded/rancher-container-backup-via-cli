#!/bin/bash

# Normalize the current working directory
WORKDIR="`dirname \"$0\"`"
cd "${WORKDIR}" || exit 1
WORKDIR=$(pwd);
