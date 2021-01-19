#!/bin/bash

##
# ONLY FOR TESTING IN LAB
##

## TO START
# curl https://raw.githubusercontent.com/anilv4/scripts/master/genfile.sh -o /root/genfile.sh
# chmod 755 genfile.sh
# nohup ./genfile.sh&

## TO STOP
# pkill -e genfile

FILE_LOCATION="/root/test_files/"
NUM=0 #File number
FILE_COUNT=1024
LOG_FILE="/root/genfile.log"

BS=2 #BLOCK SIZE for dd
COUNT=512 #COUNT for dd
WAIT_1=".002" #2ms
WAIT_2=1
RUN_NUM=1 #Run counter

while true; do
        [ -d $FILE_LOCATION ] || mkdir -p "$FILE_LOCATION"
        dd status=none if=/dev/zero of="${FILE_LOCATION}/file_${NUM}.out" bs=${BS}k count=512
        DATE=`date +%D_%T`
        sleep $WAIT_1
        let "NUM+=1"
        let "RUN_NUM+=1"
        echo $NUM
        if [ $NUM -eq $FILE_COUNT ]; then
                NUM=0
                rm -rv ${FILE_LOCATION}/file_*
                sleep $WAIT_2
        fi
        echo -e "Date is $DATE\nRun - $RUN_NUM" > ${LOG_FILE}
done
