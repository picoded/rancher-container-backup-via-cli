#!/bin/bash

##############################################################################
#
#  Builds the needed backup script from the template
#
#  Just ensure you have the files setup according to the README
#
##############################################################################

# Get the current working directory
WORKDIR="`dirname \"$0\"`"
cd "${WORKDIR}" || exit 1

# The core repor dir
CORE_DIR="${WORKDIR}/core"

# The output build script
BIN_BACKUP_SCRIPT="${WORKDIR}/bin/S3Backup.sh";
BIN_RESTORE_SCRIPT="${WORKDIR}/bin/S3Restore.sh";

# App specific backup / restore script
APP_BACKUP_SCRIPT="${WORKDIR}/config/app-backup.sh";
APP_RESTORE_SCRIPT="${WORKDIR}/config/app-restore.sh";

##############################################################################
#
#  Template handling arguments
#
##############################################################################

##############################################################################
#
#  Actual build process
#
##############################################################################

cat "${CORE_DIR}/prefix.sh" > "${BIN_BACKUP_SCRIPT}";
cat "${CORE_DIR}/prefix.sh" > "${BIN_RESTORE_SCRIPT}";
