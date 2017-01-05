#------------------------------------------------
# Mysql containers config script
# for - mysql/mysql
#------------------------------------------------

# Backup file name
BACKUP_FILENAME=workspace.zip

# Backup workspace folder (exclude last /)
BACKUP_WORKSPACE=/workspace

# File type of 'BACKUP_FILEPATH', the following are examples of valid formats
# More mime types found at : http://www.iana.org/assignments/media-types/media-types.xhtml
# NOTE: Use only when customizing templates
#
# application/x-compressed-tar
# application/x-compressed-zip
BACKUP_FILETYPE="application/x-compressed-zip"
