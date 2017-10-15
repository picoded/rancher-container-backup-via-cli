# Rename the downloaded tar appropriately
mv *.tar 1460278374_gitlab_backup.tar

# Stop processes that are connected to the database
gitlab-ctl stop unicorn
gitlab-ctl stop sidekiq

# This command will overwrite the contents of your GitLab database!
gitlab-rake gitlab:backup:restore BACKUP=1460278374

# Start GitLab
gitlab-ctl start

# Check GitLab
gitlab-rake gitlab:check SANITIZE=true