#---------------------------------------
# backup-postscript
#---------------------------------------

echo "S3Backup - completed backup file process"

echo "S3Backup - starting curl upload";

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
	
#-H "x-amz-storage-class: ${S3_CLASS}" \
#-H "x-amz-tagging: ${S3_TAG}" \
	
echo "S3Backup - completed curl upload";
