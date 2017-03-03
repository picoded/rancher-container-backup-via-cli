#------------------------------------------------
# JIRA containers backup script
# for - cptactionhank/atlassian-jira:7.0.5
#------------------------------------------------

# Making sure its correct directory
cd "${JIRA_WORKSPACE}";

# Does a permission nuke (resolve common plugin problems)
chmod -R 0777 .;

# Pack the files, tar was intentionally use as JIRA package did not inclucde zip
# Nor did it permit the easy installation of such package
tar --exclude="./${BACKUP_FILENAME}" \
	--exclude="./S3backup.sh" --exclude="./S3restore.sh" \
	--exclude="./log" --exclude="./tmp" \
	--exclude="./export" --exclude="./caches" \
	--exclude="./*.tar" \
	-cvzf "${BACKUP_FILENAME}" .;
