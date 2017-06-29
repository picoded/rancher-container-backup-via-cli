#------------------------------------------------
# mysql containers restore script
# for - mysql/mysql
#------------------------------------------------

# Remove old sql file
rm -f mysql-backup.sql;

# Unzip the sql file
unzip -uo "${BACKUP_FILENAME}" mysql-backup.sql;

# Restoration
mysql -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQLCLIENT_CONFIG --database $MYSQL_DATABASE -h 127.0.0.1 < mysql-backup.sql;
