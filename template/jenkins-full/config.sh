#-----------------------------------------------
# Jenkins containers backup
# for - picoded/jenkins:latest
#-----------------------------------------------

# Backup file name
BACKUP_FILENAME=jenkins-backup-full.zip

# Backup workspace folder (exclude last /)
BACKUP_WORKSPACE=/var/jenkins_home

# File type of 'BACKUP_FILEPATH', the following are examples of valid formats
# More mime types found at : http://www.iana.org/assignments/media-types/media-types.xhtml
# NOTE: Use only when customizing templates
#
# application/x-compressed-tar
# application/x-compressed-zip
BACKUP_FILETYPE="application/x-compressed-tar"
