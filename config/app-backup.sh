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
# Arbitary file containers : zip
#---------------------------------------
cd /workspace;             # Goes to the target folder parent
rm -f www-backup.zip       # Remove any existing backup
zip -r www-backup.zip www  # Zip up the backup

#---------------------------------------
# JIRA containers
# cptactionhank/atlassian-jira:7.0.5
#---------------------------------------
cd /var/atlassian/jira  # Goes to the target folder
rm -f jira-backup.tar   # Remove any existing backup
chmod -R 0777 .         # Does a permission nuke (resolve common plugin problems)
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
# Echo ending message
#---------------------------------------
echo "S3Backup - completed backup file process"
