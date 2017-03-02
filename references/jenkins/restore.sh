#---------------------------------------
# Jenkins containers restore script
# for - picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------

# Unzip and restore
unzip -ruvo "${BACKUP_FILENAME}" .;
