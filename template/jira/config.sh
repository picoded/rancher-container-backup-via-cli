#------------------------------------------------
# JIRA containers config script
# for - cptactionhank/atlassian-jira:7.0.5
#------------------------------------------------

# Repositories that are dependencies
export BACKUP_DEPENDS=("tar" "curl" "openssl")

# Backup workspace folder (exclude last /)
export BACKUP_WORKSPACE="/var/atlassian/jira"

# Backup file name (before S3 rename and upload)
export BACKUP_FILEPREFIX=jira-backup
export BACKUP_FILESUFFIX=".tar"

# Backup workspace folder (exclude last /)
export JIRA_WORKSPACE="/var/atlassian/jira"

# File type of 'BACKUP_FILEPATH', the following are examples of valid formats
# More mime types found at : http://www.iana.org/assignments/media-types/media-types.xhtml
# NOTE: Use only when customizing templates
#
# application/x-compressed-tar
# application/x-compressed-zip
export BACKUP_FILETYPE="application/x-compressed-tar"
