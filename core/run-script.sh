#!/bin/bash

##############################################################################
#
#  Runs the relvent backup / restore script, 
#  cross platform, with configurable config
#
#  ./run-script.sh  {backup/restore} {template name} {container name} [s3 workspace] 
#
##############################################################################

# Normalize to working dir (backup-via-cli)
WORKDIR="`dirname \"$0\"`"
cd "${WORKDIR}" || exit 1
cd "..";
WORKDIR="$(pwd)";

# Get the script status mode
TEMPLATE_MODE="$1"

# Template script mode
if [ "${TEMPLATE_MODE}" != "backup" ] && [ "${TEMPLATE_MODE}" != "restore" ] ; then
	>&2 echo ">> FATAL: TEMPLATE_MODE is invalid : ${TEMPLATE_MODE}";
	exit 1;
fi

# Get template and container name
TEMPLATE_NAME="$2"
TARGET_CONTAINER="$3"

# Does a / replacement
TARGET_CONTAINER=$(echo $TARGET_CONTAINER | sed 's|/|-|g');

if [ -z "${TEMPLATE_NAME}" ] ; then
	>&2 echo ">> FATAL: Missing TEMPLATE_NAME";
	exit 1;
fi;
if [ -z "${TARGET_CONTAINER}" ] ; then
	>&2 echo ">> FATAL: Missing TARGET_CONTAINER";
	exit 1;
fi;

# Get and normalize the workspace path
if [ -n "$4" ] ; then
	S3_WORKSPACE="$4"
fi
if [ -z "${S3_WORKSPACE}" ] ; then
	S3_WORKSPACE="${TARGET_CONTAINER}"
fi

# Include the config file
source ./config/rancher-config.sh;
source ./config/S3-config.sh;

##############################################################################
#
#  Builds the script itself
#
##############################################################################

# execution script
EXEC_SCRIPT="$(./core/generate-script.sh ${TEMPLATE_NAME} ${TEMPLATE_MODE})";

# Re-Include the config file
source ./template/${TEMPLATE_NAME}/config.sh;
source ./config/rancher-config.sh;
source ./config/S3-config.sh;

##############################################################################
#
#  Information logging
#
##############################################################################

echo ">>";
echo ">> Run mode         : ${TEMPLATE_MODE}";
echo ">> Template Name    : ${TEMPLATE_NAME}";
echo ">> Target container : ${TARGET_CONTAINER}";
echo ">> Backup workspace : ${BACKUP_WORKSPACE}";
echo ">> S3 workspace     : ${S3_WORKSPACE}";
echo ">>";

##############################################################################
#
# Actual execution
#
##############################################################################

# Temporary script name
EXEC_SCRIPTNAME="S3${TEMPLATE_MODE}.sh"

# RANCHER_EXEC_RUN_FLAGS="--privileged -i"
RANCHER_EXEC_RUN_FLAGS="-i"

# Migrating the backup / restore script
echo ">> Removing old script files (if present)";
./rancher.sh exec $RANCHER_EXEC_RUN_FLAGS $TARGET_CONTAINER rm -f "${BACKUP_WORKSPACE}/${EXEC_SCRIPTNAME}";

# Migrating the backup / restore script
echo ">> Transfering $EXEC_SCRIPTNAME script file";
echo "${EXEC_SCRIPT}" | ./rancher.sh exec $RANCHER_EXEC_RUN_FLAGS $TARGET_CONTAINER tee "${BACKUP_WORKSPACE}/${EXEC_SCRIPTNAME}";

# Permission setup
echo ">> Setting up script permissions";
./rancher.sh exec $RANCHER_EXEC_RUN_FLAGS $TARGET_CONTAINER chmod +x "${BACKUP_WORKSPACE}/${EXEC_SCRIPTNAME}";
./rancher.sh exec $RANCHER_EXEC_RUN_FLAGS $TARGET_CONTAINER chmod 0777 "${BACKUP_WORKSPACE}/${EXEC_SCRIPTNAME}";

# Executing
echo ">> Executing script file";
./rancher.sh exec -d=false $RANCHER_EXEC_RUN_FLAGS $TARGET_CONTAINER "${BACKUP_WORKSPACE}/${EXEC_SCRIPTNAME}";

# Completed run sequence
echo ">> Completed $TEMPLATE_MODE operation"
echo ">>"
