#------------------------------------------------
# JIRA containers restore script
# for - cptactionhank/atlassian-jira:7.0.5
#------------------------------------------------

chmod -R 0777 .        # Does a permission nuke (resolve common plugin problems)

tar -xvf "${BACKUP_FILENAME}"; # Uncompresses the backup out
