#-----------------------------------------------
# S3 Backup Workspace
#-----------------------------------------------

#
# Only import S3_WORKSPACE configuration  
# If its not defined externally.
#
# If you want to intentionally overwrite the config
# Comment this conditional block out.
#
if [ -z "$S3_WORKSPACE" ]; then

# S3 Filepath to upload into
# (Do not add the ending / slash)
S3_WORKSPACE=picoded/backup-via-cli

# Optionaly you can modify the respective filename
# Without the tar/zip suffix. Or leave it as it is.
#
# By default, it takes the template name.
# Note that its tar/zip suffix is decided by the template.
# 
# S3_FILENAME=custom_file_name 

fi

#-----------------------------------------------
# S3 Upload credentials for a bucket
#-----------------------------------------------

#
# Only import S3_* configuration set 
# If S3_HOST is not defined externally.
#
# If you want to intentionally overwrite the config
# Comment this conditional block out.
#
if [ -z "$S3_HOST" ]; then

# S3 bucket host region to upload into
export S3_HOST=s3-ap-southeast-1.amazonaws.com

# S3 bucket to upload into
export S3_BUCKET=your-company-backups

# S3 key used for authentication
export S3_KEY=SecretAwsS3ApiKey

# S3 secret used for authentication
export S3_SECRET=SecretAwsS3ApiSecret

#-----------------------------------------------
# Minor optimization tweaks 
# (@TODO: Not working now, to be implemented)
#-----------------------------------------------

#
# S3 Storage class
# 
# the following are possible value types:
# STANDARD | STANDARD_IA | REDUCED_REDUNDANCY
#
# We use "Infrequent Access" storage class, as backups by nature
# Should rarely be ever "read", and hence should result into cheaper
# overal S3 storage cost. I hope >_>
#
# Also presumingly due to the lack of REDUCED_REDUNDANCY usage,
# Apperantly it "lags" behind S3 price drops. Ironically making 
# it more expensive then STANDARD during that time gap.
#
export S3_CLASS=STANDARD_IA

#
# S3 storage tag
# 
# Used mainly to help track usage billing
#
export S3_TAG="type=backup"

fi
