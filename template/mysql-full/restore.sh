#------------------------------------------------
# mysql containers restore script
# for - mysql/mysql
#------------------------------------------------

# Remove old sql file
rm -f mysql-backup.sql;

# Unzip the sql file
unzip -uo "${BACKUP_FILENAME}" mysql-backup.sql;

# Restoration
mysql -u root --password=$MYSQL_ROOT_PASSWORD -h localhost < mysql-backup.sql;
