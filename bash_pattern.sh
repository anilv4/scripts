#!/bin/bash

## grep -E "Pattern|^some_log_entries" file_name > out2.txt
## sed -i '1,61280d' out2.txt

#Hour
H=7
#Starting time
X=0
#Next time
Y=2
#Day
D=8
#FILE
FILE="ou2.txt"

while [ $H -le 14 ]; do
	H=`echo "$H + 1"| bc`
	#If time less than 10, append 0. eg:- 1 -> 01
	if [ $H -lt 10 ]; then
			H=$(printf "%02d" $H)
	fi
	X=0
	Y=2
	for i in $(seq 1 29); do
		#If time less than 10, append 0. eg:- 1 -> 01
		if [ $X -lt 10 ]; then
			X=$(printf "%02d" $X)
			Y=$(printf "%02d" $Y)
		fi
		echo "$H:$X - $H:$Y"
		#Print lines between the patterns.
		sed -n "/$D\ $H:$X/,/$D\ $H:$Y/ p" $FILE|wc -l
		X=`echo "$X + 2"| bc`
		Y=`echo "$Y + 2"| bc`
	done
done
