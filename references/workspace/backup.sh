#-----------------------------------------------
# Backsup every file in the target workspace
# Excluding backup related files
#-----------------------------------------------

# Zip up the backup
zip --symlinks -r "${BACKUP_FILENAME}" . \
	-x "z" \
	-x "S3Backup.sh" \
	-x "S3Restore.sh" \
	-x "S3Backup-*.sh" \
	-x "S3Restore-*.sh" \
	-x "${BACKUP_FILENAME}";
	
# Help keep track of the output files, and help debug stuff
ls -al;
