#---------------------------------------
# Gitlab containers backup script
# for - gitlab/gitlab-ces:latest
#--------------------------------------

# # Former backup cleanup
rm -f *.tar;

# Actual backup function
gitlab-rake gitlab:backup:create 2> /dev/null;

#
# Wait for completion
#
# Sadly as the above "gitlab:backup" happens "asyncronously"
# The only way i could manage to get this script to somewhat work
# is to wait for the final .tar file (assuming it .tar succeds)
# 
# The tar file is assumed to be completed, when it has no changes for more then 10 seconds
#
while [ ! -n "$(find . -type f -iname "*.tar" -not -newermt '-10 seconds' 2> /dev/null)" ]
do
	echo ".";
	sleep 10;
done

# Rename backup
mv *_backup.tar gitlab-backup.tar;

# Something for debugging
echo ">> NOTE: gitlab-rake SHOULD finish before this message";