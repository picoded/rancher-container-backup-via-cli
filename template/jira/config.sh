#------------------------------------------------
# JIRA containers config script
# for - cptactionhank/atlassian-jira:7.0.5
#------------------------------------------------

# Backup file name
BACKUP_FILENAME=jira-backup.tar

# Backup workspace folder (exclude last /)
BACKUP_WORKSPACE=/var/atlassian/jira

# File type of 'BACKUP_FILEPATH', the following are examples of valid formats
# More mime types found at : http://www.iana.org/assignments/media-types/media-types.xhtml
# NOTE: Use only when customizing templates
#
# application/x-compressed-tar
# application/x-compressed-zip
BACKUP_FILETYPE="application/x-compressed-tar"
