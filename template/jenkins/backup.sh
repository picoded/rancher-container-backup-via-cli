#---------------------------------------
# Jenkins containers backup script
# for - picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------

# Build the backup file
#
# Excludes the backup related files
# Excludes job builds
zip -9 --symlinks -r ${BACKUP_FILENAME} . \
	-x "z" \
	-x "S3Backup.sh" \
	-x "S3Restore.sh" \
	-x "S3Backup-*.sh" \
	-x "S3Restore-*.sh" \
	-x "jenkins-*.zip" \
	-x "jobs/*/workspace/*" \
	-x "jobs/*/builds/*" \
	;
	
# Help keep track of the output files, and help debug stuff
ls -al;
