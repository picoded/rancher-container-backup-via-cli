#------------------------------------------------
# Mysql containers backup script
# for - mysql/mysql
#------------------------------------------------

# Remove old sql file
rm -f mysql-backup.sql;

# Creating the mysqldump
mysqldump -h $MYSQLHOST -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQLDUMP_CONFIG --databases $MYSQL_DATABASE -r mysql-backup.sql;

# zip the sql file up
zip -9 --verbose ${BACKUP_FILEPATH} mysql-backup.sql;

# Help keep track of the output files, and help debug stuff
ls -al;
