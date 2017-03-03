#!/bin/bash

##############################################################################
#
#  Builds the needed backup script from the template
#
#  Just ensure you have the files setup according to the README
#
##############################################################################

# Get the current working directory
COREDIR="`dirname \"$0\"`"
cd "${COREDIR}" || exit 1
COREDIR="$(pwd)";

# Time to go one level up and normalize the dir
cd ".." || exit 1;
WORKDIR="$(pwd)";

# Template directories
TEMPLATE_PARTS="${COREDIR}/template-parts"
TEMPLATE_COLLECTIONS="${WORKDIR}/template"

##############################################################################
#
#  Get the template name, and script mode
#
##############################################################################

# Template parameter defined
if [ -n "$1" ] ; then
	TEMPLATE_NAME="$1";
fi

# Check if template name is invalid
if [ -z "$TEMPLATE_NAME" ] ; then
	>&2 echo ">> FATAL: Missing template name (first argument)";
	exit 1;
fi

# Check if template folder exists
TEMPLATE_DIR="${TEMPLATE_COLLECTIONS}/${TEMPLATE_NAME}";
if [ ! -d "${TEMPLATE_DIR}" ] ; then
	>&2 echo ">> FATAL: Template does not exists : ${TEMPLATE_NAME}";
	exit 1;
fi

# Template script mode
if [ -n "$2" ] ; then
	TEMPLATE_MODE="$2";
fi

# Template script mode
if [ "${TEMPLATE_MODE}" != "backup" ] && [ "${TEMPLATE_MODE}" != "restore" ] ; then
	>&2 echo ">> FATAL: Template mode is invalid : ${TEMPLATE_MODE}";
	exit 1;
fi

##############################################################################
#
#  Configuration loading process
#
##############################################################################

# Load default depency list
BACKUP_DEPENDS=("zip" "curl" "openssl")

# Load script config
source "${TEMPLATE_DIR}/config.sh";
source "${WORKDIR}/config/S3-config.sh";

# Normalizing S3 file name (if not configured)
if [ -z "$S3_FILENAME" ] ; then
	S3_FILENAME="${TEMPLATE_NAME}${BACKUP_FILESUFFIX}"
fi

##############################################################################
#
#  Building the actual damn script
#
##############################################################################

# Utility new line variable
NEWLINE=$'\n';

# The final build script variable
# starting prefix
RETURN_SCRIPT=`cat "${TEMPLATE_PARTS}/bash-prefix.sh"`;
RETURN_SCRIPT+=$'\n\n';

#
# S3 parameters forwarding
#
RETURN_SCRIPT+=$'#--------------------------------------\n';
RETURN_SCRIPT+=$'# S3 Credentials Config \n';
RETURN_SCRIPT+=$'#--------------------------------------\n';
RETURN_SCRIPT+=$'\n';
RETURN_SCRIPT+="S3_KEY=${S3_KEY}${NEWLINE}";
RETURN_SCRIPT+="S3_SECRET=${S3_SECRET}${NEWLINE}";
RETURN_SCRIPT+="S3_BUCKET=${S3_BUCKET}${NEWLINE}";
RETURN_SCRIPT+="S3_HOST=${S3_HOST}${NEWLINE}";
RETURN_SCRIPT+="S3_TAG=${S3_TAG}${NEWLINE}";
RETURN_SCRIPT+="S3_WORKSPACE=${S3_WORKSPACE}${NEWLINE}";
RETURN_SCRIPT+="S3_FILENAME=${S3_FILENAME}${NEWLINE}";
RETURN_SCRIPT+=$'\n';

#
# Template Config script parsing
#
RETURN_SCRIPT+=`cat "${TEMPLATE_DIR}/config.sh"`;
RETURN_SCRIPT+=$'\n';
RETURN_SCRIPT+=$'\n';

#
# Dependency management, and installation
#
RETURN_SCRIPT+=$'#--------------------------------------\n';
RETURN_SCRIPT+=$'# Dependency Config \n';
RETURN_SCRIPT+=$'#--------------------------------------\n';
RETURN_SCRIPT+="BACKUP_DEPENDS=(${BACKUP_DEPENDS[@]})${NEWLINE}";
RETURN_SCRIPT+=$'\n';
RETURN_SCRIPT+=`cat "${TEMPLATE_PARTS}/dependency-installer.sh"`;

#
# Common script setup for both backup and restore
#
RETURN_SCRIPT+=`cat "${TEMPLATE_PARTS}/common-prescript.sh"`;
RETURN_SCRIPT+=$'\n';
RETURN_SCRIPT+=$'\n';

#
# Prescript
#
RETURN_SCRIPT+=`cat "${TEMPLATE_PARTS}/${TEMPLATE_MODE}-prescript.sh"`;
RETURN_SCRIPT+=$'\n';
RETURN_SCRIPT+=$'\n';

#
# THE SCRIPT from template
#
RETURN_SCRIPT+=`cat "${TEMPLATE_DIR}/${TEMPLATE_MODE}.sh"`;
RETURN_SCRIPT+=$'\n';
RETURN_SCRIPT+=$'\n';

#
# Postscript
#
RETURN_SCRIPT+=`cat "${TEMPLATE_PARTS}/${TEMPLATE_MODE}-postscript.sh"`;
RETURN_SCRIPT+=$'\n';
RETURN_SCRIPT+=$'\n';

##############################################################################
#
#  Everyting is cleared : output the result
#
##############################################################################

echo "${RETURN_SCRIPT}";
