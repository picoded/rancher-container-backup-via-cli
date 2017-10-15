#---------------------------------------
# Gitlab containers backup config
# for - gitlab/gitlab-ces:latest
#--------------------------------------

# Repositories that are dependencies
# export BACKUP_DEPENDS=("tar","curl","openssl")
export BACKUP_DEPENDS=()

# Backup workspace folder (exclude last /)
export BACKUP_WORKSPACE="/var/opt/gitlab/backups/"

# Backup file name (before S3 rename and upload)
export BACKUP_FILEPREFIX=gitlab-backup
export BACKUP_FILESUFFIX=".tar"

# File type of 'BACKUP_FILEPATH', the following are examples of valid formats
# More mime types found at : http://www.iana.org/assignments/media-types/media-types.xhtml
# NOTE: Use only when customizing templates
#
# application/x-compressed-tar
# application/x-compressed-zip
export BACKUP_FILETYPE="application/x-compressed-tar"
