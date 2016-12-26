##############################################################################
#
# This file is where you configure your application restore script
# Which actually restore the backup file, after downloading
#
# The following listed are some convinent examples
#
##############################################################################

#---------------------------------------
# Echo starting message
#---------------------------------------
echo "S3Restore - started restore process"

#---------------------------------------
# Gitlab containers
# gitlab/gitlab-ce:latest
#---------------------------------------
# Goes to the gitlab folder
cd /var/opt/gitlab/backups/;

# Rename as 1 Jan 2016 (GMT 0), to make it a valid format
mv gitlab-backup.tar 1451606400_gitlab_backup.tar;

# Stop processes that are connected to the database
sudo gitlab-ctl stop unicorn
sudo gitlab-ctl stop sidekiq

# This command will overwrite the contents of your GitLab database!
sudo gitlab-rake gitlab:backup:restore BACKUP=1451606400

# Start GitLab after restoring
sudo gitlab-ctl start

# Check GitLab
sudo gitlab-rake gitlab:check SANITIZE=true


#---------------------------------------
# Echo ending message
#---------------------------------------
echo "S3Restore - completed restore process"
