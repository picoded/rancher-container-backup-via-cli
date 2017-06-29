#------------------------------------------------
# mysql containers restore script
# for - mysql/mysql
#------------------------------------------------

# Remove old sql file
rm -f mysql-backup.sql;

# Unzip the sql file
unzip -uo "${BACKUP_FILENAME}" mysql-backup.sql;

# Restoration
mysql -h $MYSQLHOST -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQLCLIENT_CONFIG --database $MYSQL_DATABASE < mysql-backup.sql;
