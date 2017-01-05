#------------------------------------------------
# JIRA containers backup script
# for - cptactionhank/atlassian-jira:7.0.5
#------------------------------------------------

# Does a permission nuke (resolve common plugin problems)
chmod -R 0777 .;

# Pack the files, tar was intentionally use as JIRA package did not inclucde zip
# Nor did it permit the easy installation of such package
tar --exclude="./${BACKUP_FILENAME}" \
	--exclude="./S3Backup.sh" --exclude="./S3Restore.sh" \
	--exclude="./log" --exclude="./tmp" \
	--exclude="./export" --exclude="./caches" \
	-cvzf "jira-backup.tar" .;
