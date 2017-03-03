#---------------------------------------
# Jenkins containers backup script
# for - picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------

# Ensure file path is jenkins workspace
cd "${JENKINS_WORKSPACE}";

# Build the backup file
#
# Excludes the backup related files
# Excludes job builds
zip -9 --verbose --symlinks -r ${BACKUP_FILEPATH} ${JENKINS_WORKSPACE} \
	-x "z" \
	-x "S3backup.sh" \
	-x "S3restore.sh" \
	-x "*.zip" \
	-x "jobs/*/workspace/*" \
	-x "jobs/*/builds/*" \
	;
	
# Help keep track of the output files, and help debug stuff
ls -al;
