#---------------------------------------
# restore-prescript
#---------------------------------------

echo "S3Restore - starting curl download";

# remove the old backup file (if present)
rm -f "${BACKUP_FILEPATH}";

# curl working vars
UNIX_TIMESTAMP=`date +%s`
CURL_DATEVALUE=`date -R`
CURL_RESOURCEPATH="/${S3_BUCKET}/${S3_FILEPATH}"
CURL_STRINGTOSIGN="GET\n\n${BACKUP_FILETYPE}\n${CURL_DATEVALUE}\n${CURL_RESOURCEPATH}"
CURL_SIGNATURE=`echo -en ${CURL_STRINGTOSIGN} | openssl sha1 -hmac ${S3_SECRET} -binary | base64`

# Downloading file
echo "S3Restore - downloading : https://${S3_BUCKET}.${S3_HOST}/${S3_FILEPATH}";

# curl execution
curl \
	--progress-bar \
	-H "Host: ${S3_BUCKET}.s3.amazonaws.com" \
	-H "Date: ${CURL_DATEVALUE}" \
	-H "Content-Type: ${BACKUP_FILETYPE}" \
	-H "Authorization: AWS ${S3_KEY}:${CURL_SIGNATURE}" \
	-o "${BACKUP_FILEPATH}" \
	-L "https://${S3_BUCKET}.${S3_HOST}/${S3_FILEPATH}?t=$UNIX_TIMESTAMP";

echo "S3Restore - completed curl download";

# Permission reset
chmod 0777 "${BACKUP_FILEPATH}";

echo "S3Restore - started restore file process"
