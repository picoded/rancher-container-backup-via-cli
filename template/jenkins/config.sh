#---------------------------------------
# Jenkins containers backup config
# for - picoded/jenkins:latest
#
# Weekly full varient
#--------------------------------------

# Repositories that are dependencies
# export BACKUP_DEPENDS=("zip" "curl" "openssl")

# Backup workspace folder (exclude last /)
export BACKUP_WORKSPACE="/tmp"

# Backup file name (before S3 rename and upload)
export BACKUP_FILEPREFIX=jenkins-full-backup
export BACKUP_FILESUFFIX=".zip"

# File type of 'BACKUP_FILEPATH', the following are examples of valid formats
# More mime types found at : http://www.iana.org/assignments/media-types/media-types.xhtml
# NOTE: Use only when customizing templates
#
# application/x-compressed-tar
# application/x-compressed-zip
export BACKUP_FILETYPE="application/x-compressed-zip"

# Jenkins workspace
export JENKINS_WORKSPACE=/var/jenkins_home

# Run shell as root user (-u i)
export RUN_SHELL_AS_ROOT=1
