#------------------------------------------------
# Mysql containers config script
# for - mysql/mysql
#------------------------------------------------

# Repositories that are dependencies
export BACKUP_DEPENDS=("mysql" "zip" "curl" "openssl")

# Backup workspace folder (exclude last /)
export BACKUP_WORKSPACE="/tmp"

# Backup file name (before S3 rename and upload)
export BACKUP_FILEPREFIX=mysql-backup
export BACKUP_FILESUFFIX=".zip"

# File type of 'BACKUP_FILEPATH', the following are examples of valid formats
# More mime types found at : http://www.iana.org/assignments/media-types/media-types.xhtml
# NOTE: Use only when customizing templates
#
# application/x-compressed-tar
# application/x-compressed-zip
export BACKUP_FILETYPE="application/x-compressed-zip"

# Hostname (for external backups)
export MYSQLHOST="127.0.0.1"

# Mysqldump configuration
export MYSQLDUMP_CONFIG="--add-drop-table --add-locks --create-options --disable-keys --extended-insert --quick --default-character-set=utf8mb4 --set-charset --skip-lock-tables "
export MYSQLCLIENT_CONFIG="--default-character-set=utf8mb4 "
