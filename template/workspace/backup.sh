#-----------------------------------------------
# Backsup every file in the target workspace
# Excluding backup related files
#-----------------------------------------------

cd "${BACKUP_WORKSPACE}";        # Goes to the target folder
rm -f "${BACKUP_FILENAME}";      # Remove any existing backup

zip --symlinks -r "${BACKUP_FILENAME}" . \  # Zip up the backup
	# Exclude the backup related files
	-x "z" \
	-x "S3Backup-*.sh" \
	-x "S3Restore-*.sh" \
	-x "${BACKUP_FILENAME}";
