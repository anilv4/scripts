#!/bin/bash

##
# ONLY FOR TESTING IN LAB
# genfile.sh will create 1MiB files in a directory and delete those files in a loop based on FILE_COUNT
##

## To start
# curl https://raw.githubusercontent.com/anilv4/scripts/master/genfile.sh -o /root/genfile.sh
# chmod 755 genfile.sh
# nohup ./genfile.sh&

## Status check
# cat /root/genfile.log
# ls /root/test_files

## TO stop
# pkill -e genfile

## General configs
FILE_LOCATION="/root/test_files/"
LOG_FILE="/root/genfile.log"
FILE_COUNT=1024 #Max number of 1MiB files to reach before delete

## dd configs
BS=2 #BLOCK SIZE for dd
COUNT=512 #COUNT for dd
DD_STATUS="none"

## sleep configs
WAIT_1=".002" #2ms
WAIT_2=1

## No need to change
NUM=0 #File number
RUN_NUM=1 #Run counter

while true; do
        [ -d $FILE_LOCATION ] || mkdir -p "$FILE_LOCATION"
        dd status=$DD_STATUS if=/dev/zero of="${FILE_LOCATION}/file_${NUM}.out" bs=${BS}k count=$COUNT
        DATE=`date +%D_%T`
        sleep $WAIT_1
        let "NUM+=1"
        let "RUN_NUM+=1"
        if [ $NUM -eq $FILE_COUNT ]; then
                NUM=0
                rm -rf ${FILE_LOCATION}/file_*
                sleep $WAIT_2
        fi
        echo -e "Date is $DATE\nRun - $RUN_NUM" > ${LOG_FILE}
done
