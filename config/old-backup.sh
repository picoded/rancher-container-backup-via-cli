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
# JIRA containers
# cptactionhank/atlassian-jira:7.0.5
#---------------------------------------
cd /var/atlassian/jira  # Goes to the target folder
rm -f jira-backup.tar   # Remove any existing backup
chmod -R 0777 .         # Does a permission nuke (resolve common plugin problems)

# Pack the files, tar was intentionally use as JIRA package did not inclucde zip
# Nor did it permit the easy installation of such package
tar --exclude="./jira-backup.tar" \
	--exclude="./S3Backup.sh" --exclude="./S3Restore.sh" \
	--exclude="./log" --exclude="./tmp" 
	--exclude="./export" --exclude="./caches" 
	-cvzf "jira-backup.tar" .;
	
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
# Jenkins containers backup
# picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------
cd /var/jenkins_home;       # Goes to the jenkins home
rm -f jenkins-backup-full.zip;   # Remove the previous backup file

# Build the backup file
zip --symlinks -r jenkins-backup-full.zip . \ 
	# Exclude the backup related files
	-x "z" \
	-x "S3Backup.sh" \
	-x "S3Restore.sh" \
	-x "S3Backup-full.sh" \
	-x "S3Restore-full.sh" \
	-x "jenkins-backup.zip" \
	-x "jenkins-backup-full.zip" \
	# Exclude only job builds
	-x "jobs/*/workspace/*" \
	-x "jobs/*/builds/*" \
	;

#---------------------------------------
# Echo ending message
#---------------------------------------
echo "S3Backup - completed backup file process"
