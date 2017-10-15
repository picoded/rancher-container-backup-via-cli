#---------------------------------------
# Gitlab containers backup script
# for - gitlab/gitlab-ces:latest
#--------------------------------------

# To create the gitlab backup itself (WARNING DELTES ALL OLD COPIES)
# cd /var/opt/gitlab/backups/;

# Former backup cleanup
# rm -f *.tar;

# # Actual backup
# gitlab-rake gitlab:backup:create;

# # Wait for backup to finish
# wait;

# Upload of backup
mv *_backup.tar gitlab-backup.tar;

# rsync -ah --progress