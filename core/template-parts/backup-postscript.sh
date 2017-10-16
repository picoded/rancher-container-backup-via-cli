#---------------------------------------
# backup-postscript
#---------------------------------------

echo "S3Backup - completed backup file process"

echo "S3Backup - starting upload";

# UPLOAD using Python toolchain, if file size is larger then 5gb
if [[ $(find "${BACKUP_FILEPATH}" -type f -size +5G 2>/dev/null) ]]; then
	USE_S3CLI=1
fi

if [ -n "${USE_S3CLI}" ] ; then
	#
	# Use large size python multipart upload
	#

	# Install python pip
	echo ">>> Ensuring dependency is installed : python-pip"
	if [ -z "$(which pip)" ] ; then
		# apt-get found, use it
		if [ -n "$PATH_APTGET" ] ; then
			apt-get update || true;
			apt-get install -y python-pip || true;
		fi;
		# yum found, use it
		if [ -n "$PATH_YUM" ] ; then
			yum update || true;
			yum install -y python-pip || true;
		fi;

		# ensure pip command is setup
		export PATH=$(which pip):$PATH;
	fi;

	# Upgrade pip
	pip install --upgrade pip;

	# Install aws CLI
	pip install awscli --upgrade --user;

	# Get python install path
	export PATH=~/.local/bin:$PATH;

	# Prepare the aws credentials
	export AWS_ACCESS_KEY_ID="$S3_KEY"
	export AWS_SECRET_ACCESS_KEY="$S3_SECRET"

	# Copies the file over
	aws s3 cp "${BACKUP_FILEPATH}" "s3://${S3_BUCKET}/${S3_FILEPATH}"

else
	#
	# Use curl upload
	#

	# curl working vars
	CURL_DATEVALUE=`date -R`
	CURL_RESOURCEPATH="/${S3_BUCKET}/${S3_FILEPATH}"
	CURL_STRINGTOSIGN="PUT\n\n${BACKUP_FILETYPE}\n${CURL_DATEVALUE}\n${CURL_RESOURCEPATH}"
	CURL_SIGNATURE=`echo -en ${CURL_STRINGTOSIGN} | openssl sha1 -hmac ${S3_SECRET} -binary | base64`

	# curl execution
	curl -X PUT -T "${BACKUP_FILEPATH}" \
		-H "Host: ${S3_BUCKET}.s3.amazonaws.com" \
		-H "Date: ${CURL_DATEVALUE}" \
		-H "Content-Type: ${BACKUP_FILETYPE}" \
		-H "Authorization: AWS ${S3_KEY}:${CURL_SIGNATURE}" \
		-L https://${S3_BUCKET}.${S3_HOST}/${S3_FILEPATH};
fi

#-H "x-amz-storage-class: ${S3_CLASS}" \
#-H "x-amz-tagging: ${S3_TAG}" \
	
echo "S3Backup - completed upload";
