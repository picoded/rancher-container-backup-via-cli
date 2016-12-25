#-----------------------------------------------
# Backsup every file in the target workspace
# Excluding backup related files
#-----------------------------------------------

zip --symlinks -r "${BACKUP_FILENAME}" . \  # Zip up the backup
	# Exclude the backup related files
	-x "z" \
	-x "S3Backup.sh" \
	-x "S3Restore.sh" \
	-x "S3Backup-*.sh" \
	-x "S3Restore-*.sh" \
	-x "${BACKUP_FILENAME}";
