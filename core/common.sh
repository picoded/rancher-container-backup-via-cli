#---------------------------------------
# Core Template - setup config checks
#---------------------------------------

#
# Common vars concat
#

# Filepath to upload to S3
BACKUP_FILEPATH=${BACKUP_WORKSPACE}/${BACKUP_FILENAME}

# S3 Filepath to upload into
S3_FILEPATH=${S3_WORKSPACE}/${BACKUP_FILENAME}

#
# Fetch dependency commands file path (to validate)
#
PATH_ZIP=$(which zip); 
PATH_CURL=$(which curl);
PATH_OPENSSL=$(which openssl);
PATH_APTGET=$(which apt-get);
PATH_YUM=$(which yum);

#
# Check if dependency is missing, and if so, install them
#
if [ -z "$PATH_ZIP" ] || [ -z "$PATH_CURL" ] || [ -z "$PATH_OPENSSL" ] ; then
	# apt-get found, use it
	if [ -n "$PATH_APTGET" ] ; then
		apt-get update || true;
		apt-get install -y zip curl openssl || true;
	fi;
	# yum found, use it
	if [ -n "$PATH_APTGET" ] ; then
		yum update || true;
		yum install -y zip curl openssl || true;
	fi;
fi
