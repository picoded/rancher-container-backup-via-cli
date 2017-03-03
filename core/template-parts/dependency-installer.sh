#-----------------------------------------------
# Dependency installer
#-----------------------------------------------
PATH_APTGET=$(which apt-get);
PATH_YUM=$(which yum);

echo ">>> Ensuring dependencies : ${BACKUP_DEPENDS[@]}"
for DEP in "${BACKUP_DEPENDS[@]}"
do
	echo ">>> Ensuring dependency is installed : ${DEP}"
	if [ -z "$(which ${DEP})" ] ; then
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
	fi
done