#---------------------------------------
# Jenkins containers backup script
# for - picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------

# Nuke tmp files
rm -R -f /tmp/*;

# Ensure file path is jenkins workspace
cd "${JENKINS_WORKSPACE}";

# Unfortunately due to how complicated the permission
# system is in the jenkins container. This nuke is needed
# to make the backup work : someone fix this please
chmod -R 0777 .;
chmod -R +x .;

# Build the backup file
#
# Excludes the backup related files
# Excludes job builds
zip -9 --verbose --symlinks -r ${BACKUP_FILEPATH} . \
	-x "z" \
	-x "S3backup.sh" \
	-x "S3restore.sh" \
	-x "S3Backup.sh" \
	-x "S3Restore.sh" \
	-x "*.zip" \
	-x "jobs/*/workspace/*" \
	-x "jobs/*/builds/*" \
	-x "workspace/*" \
	-x "caches/*" \
	;
	
# Help keep track of the output files, and help debug stuff
ls -al;
