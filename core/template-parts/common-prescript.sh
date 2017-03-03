
# Normalizing backup filename
BACKUP_FILENAME="${BACKUP_FILEPREFIX}${BACKUP_FILESUFFIX}"

# Normalizing backup workspace
if [ -z "${BACKUP_WORKSPACE}" ] ; then
	BACKUP_WORKSPACE="/workspace";
fi;

# Filepath to upload to S3
BACKUP_FILEPATH="${BACKUP_WORKSPACE}/${BACKUP_FILENAME}"

# S3 Filepath to upload into
S3_FILEPATH="${S3_WORKSPACE}/${S3_FILENAME}"

#
# Goes to workspace dir, remove old backup,
# Run rest of the script from there
#
cd "${BACKUP_WORKSPACE}";
rm -f "${BACKUP_FILEPATH}";
