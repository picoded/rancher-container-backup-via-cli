#---------------------------------------
# Jenkins containers restore script
# for - picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------

# Unzip and restore
unzip -r "${BACKUP_FILENAME}";
