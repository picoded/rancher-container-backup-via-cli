#---------------------------------------
# Jenkins containers backup script
# for - picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------

# Build the backup file
zip --symlinks -r ${BACKUP_FILENAME}.zip . \ 
	# Exclude the backup related files
	-x "z" \
	-x "S3Backup.sh" \
	-x "S3Restore.sh" \
	-x "S3Backup-*.sh" \
	-x "S3Restore-*.sh" \
	-x "jenkins-*.zip" \
	# Exclude only job builds
	-x "jobs/*/workspace/*" \
	-x "jobs/*/builds/*" \
	;
