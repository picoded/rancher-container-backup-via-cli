#-----------------------------------------------
# Restore the relevent file
# Excluding backup related files
#-----------------------------------------------

cd "${BACKUP_WORKSPACE}";        # Goes to the target folder
unzip -r "${BACKUP_FILENAME}";
