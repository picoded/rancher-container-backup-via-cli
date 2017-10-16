#---------------------------------------
# Jenkins containers restore script
# for - picoded/jenkins:latest
#
# Weekly full varient
#---------------------------------------

# Ensure file path is jenkins workspace
cd "${JENKINS_WORKSPACE}";

# Unfortunately due to how complicated the permission
# system is in the jenkins container. This nuke is needed
# to make the backup work : someone fix this please
chmod -R 0777 .;
chmod -R +x .;

# Unzip and restore
unzip -o "${BACKUP_FILEPATH}" -d ${JENKINS_WORKSPACE};

# Unfortunately due to how complicated the permission
# system is in the jenkins container. This nuke is needed
# to make the backup work : someone fix this please
chmod -R 0777 .;
chmod -R +x .;
