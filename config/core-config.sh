#-----------------------------------------------
# S3 Upload credentials for a bucket
#-----------------------------------------------

# S3 key used for authentication
S3_KEY=SecretAwsS3ApiKey

# S3 secret used for authentication
S3_SECRET=SecretAwsS3ApiSecret

# S3 bucket to upload into
S3_BUCKET=your-company-backups

# S3 bucket host region to upload into
S3_HOST=s3-ap-southeast-1.amazonaws.com

#-----------------------------------------------
# Minor optimization tweaks
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
S3_CLASS=STANDARD_IA

#
# S3 storage tag
# 
# Used mainly to help track usage billing
#
S3_TAG=BACKUP
