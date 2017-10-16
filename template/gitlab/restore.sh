# Rename the downloaded tar appropriately
mv *.tar 1460278374_gitlab_backup.tar;

# Stop processes that are connected to the database
gitlab-ctl stop unicorn;
gitlab-ctl stop sidekiq;

# This command will overwrite the contents of your GitLab database!
# Start up gitlab again and performs checks
gitlab-rake gitlab:backup:restore BACKUP=1460278374 force=yes &&
gitlab-ctl start &&
gitlab-rake gitlab:check SANITIZE=true;