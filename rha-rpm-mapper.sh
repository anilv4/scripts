#!/bin/bash

##
# FOR TESTING PURPOSE ONLY.
# version 1.01
# rh-rpm-mapper.sh will map a RH advisory to a rpm. The output will be saved in csv format.
# ./rha-rpm-mapper.sh <RHA_CSV_FILE.csv>
##

[ -z "$1" ] && { echo -e "\nSecurity CSV file missing"; exit 1; }

SEC_CSV_FILE="$1"
UPDATEINFO_FILE="updateinfo_`date +%F`.txt"
OUTPUT_FILE="rha_to_rpm_`date +%F_%T`.csv"
MISSING_FILE="missing_rha_to_rpm`date +%F_%T`.csv"

echo -e "\nGenerating update info file: $UPDATEINFO_FILE"
yum updateinfo list all > $UPDATEINFO_FILE

echo "Generating the mapping csv file: $OUTPUT_FILE"
echo "Mapping failed csv file: $MISSING_FILE"

for RHID in `cut -d\, -f1 $SEC_CSV_FILE|grep "RH"`; do
	if grep -q $RHID $UPDATEINFO_FILE; then
		grep $RHID $UPDATEINFO_FILE | sed 's/^i/\ /' | awk '{print $1",",$3}' >> $OUTPUT_FILE
	else
		echo "$RHID, MISSING" >> $MISSING_FILE
	fi
done
