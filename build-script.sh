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

# The core/config/tempate dir
CORE_DIR="${WORKDIR}/core"
CONFIG_DIR="${WORKDIR}/config"
TEMPLATE_DIR="${WORKDIR}/template"

# The config files
CONFIG_CORE="${CONFIG_DIR}/core-config.sh";
CONFIG_APP="${CONFIG_DIR}/app-config.sh";

# The output build script
BIN_BACKUP_SCRIPT="${WORKDIR}/bin/S3Backup.sh";
BIN_RESTORE_SCRIPT="${WORKDIR}/bin/S3Restore.sh";

# App specific backup / restore script
APP_BACKUP_SCRIPT="${WORKDIR}/config/app-backup.sh";
APP_RESTORE_SCRIPT="${WORKDIR}/config/app-restore.sh";

# Template mode, to overwrite
TEMPLATE_MODE="CUSTOM"
TEMPLATE_CONFIG="";

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

echo "Building backup & restore scripts, using the following files as conifig";
echo " Template Mode:   ${TEMPLATE_MODE}"
echo " Core config:     ${CONFIG_CORE}";
echo " App config:      ${CONFIG_APP}";
echo " Backup script:   ${APP_BACKUP_SCRIPT}";
echo " Restore script:  ${APP_RESTORE_SCRIPT}";

# Setup the prefix
cat "${CORE_DIR}/prefix.sh" > "${BIN_BACKUP_SCRIPT}";
cat "${CORE_DIR}/prefix.sh" > "${BIN_RESTORE_SCRIPT}";
echo "" >> "${BIN_BACKUP_SCRIPT}";
echo "" >> "${BIN_RESTORE_SCRIPT}";

# Template based config (if given)
if [ -n "${TEMPLATE_CONFIG}" ] ; then
	echo " Template config: ${TEMPLATE_CONFIG}";
	cat "${TEMPLATE_CONFIG}" > "${BIN_BACKUP_SCRIPT}";
	cat "${TEMPLATE_CONFIG}" > "${BIN_RESTORE_SCRIPT}";
fi

# Setup the core config
cat "${CONFIG_CORE}" >> "${BIN_BACKUP_SCRIPT}";
cat "${CONFIG_CORE}" >> "${BIN_RESTORE_SCRIPT}";
echo "" >> "${BIN_BACKUP_SCRIPT}";
echo "" >> "${BIN_RESTORE_SCRIPT}";

# Setup the app config
cat "${CONFIG_APP}" >> "${BIN_BACKUP_SCRIPT}";
cat "${CONFIG_APP}" >> "${BIN_RESTORE_SCRIPT}";
echo "" >> "${BIN_BACKUP_SCRIPT}";
echo "" >> "${BIN_RESTORE_SCRIPT}";

# Setup the common setup
cat "${CORE_DIR}/common.sh" >> "${BIN_BACKUP_SCRIPT}";
cat "${CORE_DIR}/common.sh" >> "${BIN_RESTORE_SCRIPT}";
echo "" >> "${BIN_BACKUP_SCRIPT}";
echo "" >> "${BIN_RESTORE_SCRIPT}";

# Setup the backup, then upload process
echo 'echo "S3Backup - started backup file process"' >> "${BIN_BACKUP_SCRIPT}";
echo "" >> "${BIN_BACKUP_SCRIPT}";
cat "${APP_BACKUP_SCRIPT}" >> "${BIN_BACKUP_SCRIPT}";
echo "" >> "${BIN_BACKUP_SCRIPT}";
echo 'echo "S3Backup - completed backup file process"' >> "${BIN_BACKUP_SCRIPT}";
echo "" >> "${BIN_BACKUP_SCRIPT}";
cat "${CORE_DIR}/S3Backup.sh" >> "${BIN_BACKUP_SCRIPT}";
echo "" >> "${BIN_BACKUP_SCRIPT}";

# Setup the download, then restore process
cat "${CORE_DIR}/S3Restore.sh" >> "${BIN_RESTORE_SCRIPT}";
echo "" >> "${BIN_RESTORE_SCRIPT}";
echo 'echo "S3Restore - started restore file process"' >> "${BIN_RESTORE_SCRIPT}";
echo "" >> "${BIN_RESTORE_SCRIPT}";
cat "${APP_RESTORE_SCRIPT}" >> "${BIN_RESTORE_SCRIPT}";
echo "" >> "${BIN_RESTORE_SCRIPT}";
echo 'echo "S3Backup - completed restore file process"' >> "${BIN_RESTORE_SCRIPT}";
echo "" >> "${BIN_RESTORE_SCRIPT}";
