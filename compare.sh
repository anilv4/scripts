#!/bin/bash

###
# FOR TESTING PURPOSE ONLY
# v1.02 
# This script will download a configuration file and then compare that with a local file in the system.
# If there is a change, the local file will be replaced by the downloaded file.
# 
# To run,
# CHANGE SRCURL and LOCALFILE as per your environment
# ./compare.sh
###

SRCURL="http://example.com/sysctl.conf.kvm"
LOCALFILE="/etc/sysctl.conf"

TMPFILE="/tmp/deployfile.${RANDOM}"

#Downloading $SRCURL to $TMPDIR. Exit if download failed.
curl -sf "$SRCURL" -o "$TMPFILE" || { echo -e "\n$SRCURL download failed"; exit 1; }

if [ -f "$TMPFILE" ]; then
	if `cmp -s "$TMPFILE" "$LOCALFILE"`; then
		echo ""$TMPFILE" is same as "$LOCALFILE""
	else
		echo "Taking backup of $LOCALFILE"
		cp -fv "$LOCALFILE" "${LOCALFILE}_`date +%F-%T`"
		cp -f "$TMPFILE" "$LOCALFILE"
		echo ""$LOCALFILE" is replaced by "$TMPFILE""
	fi
	rm -f $TMPFILE
fi
