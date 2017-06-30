#-----------------------------------------------
# Dependency installer
#-----------------------------------------------
PATH_APTGET=$(which apt-get);
PATH_YUM=$(which yum);
PATH_APK=$(which apk);

echo ">>> Ensuring dependencies : ${BACKUP_DEPENDS[@]}"
for DEP in "${BACKUP_DEPENDS[@]}"
do
	# Does a special rewrite for checking mysql-client as mysql
	EXC_DEP="${DEP}";
	if [ "${EXC_DEP}" == "mysql-client" ] ; then
		EXC_DEP="mysql";
	fi;
	
	echo ">>> Ensuring dependency is installed : ${DEP}"
	if [ -z "$(which ${EXC_DEP})" ] ; then
		# apt-get found, use it
		if [ -n "$PATH_APTGET" ] ; then
			apt-get update || true;
			apt-get install -y ${DEP} || true;
		fi;
		# yum found, use it
		if [ -n "$PATH_APTGET" ] ; then
			yum update || true;
			yum install -y ${DEP} || true;
		fi;
		# APK found, use it
		if [ -n "$PATH_APK" ] ; then
			apk update || true;
			apk add ${DEP} || true;
		fi;
	fi
done