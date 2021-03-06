#---------------------------------------
# Core Template - Rancher execution
#---------------------------------------

#
# Install docker client if needed
#
if [ -z "$(which docker)" ] ; then
	PATH_APTGET=$(which apt-get);
	PATH_YUM=$(which yum);
	echo ">> Docker client is missing, doing install steps (if possible)";
	
	# apt-get found, use it
	if [ -n "$PATH_APTGET" ] ; then
		apt-get update || true;
		apt-get install -y docker.io || true;
	fi;
	# yum found, use it
	if [ -n "$PATH_APTGET" ] ; then
		yum update || true;
		yum install -y docker || true;
	fi;
fi

#
# Setup target environment variable to replace
# Ranchers default configuration (if configured)
#

# The URL of the target rancher machine to use
if [ -n "${TARGET_RANCHER_URL}" ] ; then
	export RANCHER_URL="${TARGET_RANCHER_URL}";
fi

# rancher login access key
if [ -n "${TARGET_RANCHER_ACCESS_KEY}" ] ; then
	export RANCHER_ACCESS_KEY="${TARGET_RANCHER_ACCESS_KEY}";
fi

# rancher login secret key
if [ -n "${TARGET_RANCHER_SECRET_KEY}" ] ; then
	export RANCHER_SECRET_KEY="${TARGET_RANCHER_SECRET_KEY}";
fi

# target environment to use
if [ -n "${TARGET_RANCHER_ENVIRONMENT}" ] ; then
	export RANCHER_ENVIRONMENT="${TARGET_RANCHER_ENVIRONMENT}";
fi

#
# Script call configuration
#

# Assuming modes, and validating it
TARGET_MODE=$1;
TARGET_CONTAINER=$2;
TARGET_SCRIPT="S3Backup.sh";

# Target Mode check
if [ -z "$TARGET_MODE" ] ; then
	echo ">> ./run-script.sh MODE CONTAINER";
	echo ">> Missing target mode argument: (backup/restore)";
	exit 1;
fi

# Target container check
if [ -z "$TARGET_CONTAINER" ] ; then
	echo ">> ./run-script.sh MODE CONTAINER";
	echo ">> Missing target container argument: (stack-container-id)";
	exit 1;
fi

# Target script to run
if [ "$TARGET_MODE" = "restore" ] ; then 
	TARGET_SCRIPT="S3Restore.sh";
fi

echo ">> Target run mode  : $TARGET_MODE";
echo ">> Target container : $TARGET_CONTAINER";

#
# Move one folder above execution bin dir
#
cd "${WORKDIR}";
cd ..;

#
# Rancher CLI detection mode
#
if [[ "$OSTYPE" == "darwin"* ]]; then
	echo ">> Assuming mac osx 'darwin' for rancher CLI";
	RANCHER_CLI="./rancher-osx"
else
	echo ">> Assuming 'linux' for rancher CLI";
	RANCHER_CLI="./rancher"
fi

#
# Actual execution
#
# RANCHER_EXEC_RUN_FLAGS="--privileged -i"
RANCHER_EXEC_RUN_FLAGS="-i"

# File Transfer script
echo ">> Transfering $TARGET_SCRIPT file";
cat "./bin/$TARGET_SCRIPT" | $RANCHER_CLI exec $RANCHER_EXEC_RUN_FLAGS $TARGET_CONTAINER tee "${BACKUP_WORKSPACE}/${TARGET_SCRIPT}";

# Setup its permission, and run it
echo ">> Executing $TARGET_SCRIPT file";
$RANCHER_CLI exec $RANCHER_EXEC_RUN_FLAGS $TARGET_CONTAINER chmod +x "${BACKUP_WORKSPACE}/${TARGET_SCRIPT}" >&1 2>&2 ;
$RANCHER_CLI exec $RANCHER_EXEC_RUN_FLAGS $TARGET_CONTAINER "${BACKUP_WORKSPACE}/${TARGET_SCRIPT}" >&1 2>&2 ;

# Completed run sequence
echo ">> Completed $TARGET_MODE operation"
