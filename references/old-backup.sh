##############################################################################
#
# This file is where you configure your application backup script
# Which actually created the backup file, prior to uploading
#
# Note that most of these scripts normally delete the old backups locally
#
# The following listed are some convinent examples
#
##############################################################################

#---------------------------------------
# Echo starting message
#---------------------------------------
echo "S3Backup - started backup file process"

#---------------------------------------
# Gitlab containers
# gitlab/gitlab-ce:latest
#---------------------------------------
cd /var/opt/gitlab/backups/;            # Goes to the gitlab folder
rm -f *.tar;                            # Remove any existing backup
sudo gitlab-rake gitlab:backup:create;  # Create the backup file
mv *.tar gitlab-backup.tar;             # Rename the backup file for upload

#---------------------------------------
# Jenkins containers backup
# picoded/jenkins:latest
#
# Daily lite varient
#---------------------------------------
cd /var/jenkins_home;       # Goes to the jenkins home
rm -f jenkins-backup.zip;   # Remove the previous backup file

# Build the backup file
zip --symlinks -r jenkins-backup.zip . \ 
	# Exclude the backup related files
	-x "z" \
	-x "S3Backup.sh" \
	-x "S3Restore.sh" \
	-x "S3Backup-full.sh" \
	-x "S3Restore-full.sh" \
	-x "jenkins-backup.zip" \
	-x "jenkins-backup-full.zip" \
	# Exclude plugins, historical, cache, and workspace/job files
	-x "config-history/*" \
	-x "jobs/*/workspace/*" \
	-x "jobs/*/builds/*" \
	-x "workspace/*" \
	-x "plugins/*.bak" \
	-x "plugins/*/*" \
	-x "war/*" \
	-x "cache/*" \
	-x "caches/*" \
	;
	
#---------------------------------------
# Echo ending message
#---------------------------------------
echo "S3Backup - completed backup file process"
