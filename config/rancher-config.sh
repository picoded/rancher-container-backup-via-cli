#----------------------------------------------------------
# Rancher configuration script : to overwrite,
#
# For the configuration value details, see:
# http://docs.rancher.com/rancher/v1.2/en/cli/
#----------------------------------------------------------

#
# Only import RANCHER_* configuration set 
# If its not defined externally.
#
# If you want to intentionally overwrite the config
# Comment this conditional block out.
#
if [ -z "$RANCHER_URL" ]; then

# The URL of the target rancher machine to use
export RANCHER_URL="https://<your-rancher.com>/"

# rancher login access key
export RANCHER_ACCESS_KEY="<access-key>"

# rancher login secret key
export RANCHER_SECRET_KEY="<secret-key>"

# target environment to use
export RANCHER_ENVIRONMENT="<env-id>"

fi