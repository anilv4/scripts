#!/bin/bash
# Not a working script.
# Only for storing some interesting codes for reuse.


# Parsing json using jq
for i in `ls ${LOC}/json/*json`; do
  # jq to do a conditional query with two conditions
  VALUES=`jq -r '.[]| select(.isActive==true and .assetClass=="Total")|"\(.totalCost) \(.currentValue)"' $i`
  # basename needs xargs. 
  # echo $i | cut -d\- -f1,2,3 # for reference 
  DATE=`echo $i | xargs basename | awk -F"-" '{print $1 "/" $2 "/" $3}'`
  echo "$DATE $VALUES"
done | uniq > "$LOCPLOT"

LOCATION="/amount/point/file.out"
while true; do 
  date 
  time dd if=/dev/zero of="${LOCATION}.$RANDOM" bs=10K count=50
  echo "-------" 
  sleep 1 
done
