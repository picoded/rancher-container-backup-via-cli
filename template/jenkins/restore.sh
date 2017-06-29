#---------------------------------------
# Jenkins containers restore script
# for - picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------

# Unzip and restore
unzip -uo "${BACKUP_FILEPATH}" -d ${JENKINS_WORKSPACE};
