#---------------------------------------
# Gitlab containers backup script
# for - gitlab/gitlab-ces:latest
#--------------------------------------

# # Former backup cleanup
rm -f *.tar;

# Actual backup
trap 'gitlab-rake gitlab:backup:create' SIGTERM SIGINT SIGFPE SIGSTP EXIT SIGHUP SIGQUIT;

# Wait for completion
wait < <(jobs -p);
mv *_backup.tar gitlab-backup.tar;

# Something for debugging
echo ">> NOTE: gitlab-rake SHOULD finish before this message";