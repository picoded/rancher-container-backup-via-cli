#-----------------------------------------------
# Backup file location, and type
#-----------------------------------------------

# Filepath to upload to S3
BACKUP_FILEPATH=/some/file/path/with/backup.tar

# File type of 'BACKUP_FILEPATH', the following are examples of valid formats
# More mime types found at : http://www.iana.org/assignments/media-types/media-types.xhtml
#
# application/x-compressed-tar
# application/x-compressed-zip
BACKUP_FILETYPE="application/x-compressed-tar"

#-----------------------------------------------
# S3 Upload file path
#-----------------------------------------------

# S3 Filepath to upload into
S3_FILEPATH=appname/backup.tar
