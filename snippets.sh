#!/bin/bash
# Not a working script.
# Only for storing some interesting codes for reuse.


# Parsing json using jq
for i in `ls ${LOC}/json/*json`; do
  # jq to query json
  VALUES=`jq -r '.[0]| select(.isActive==true)|"\(.totalCost) \(.currentValue)"' $i`
  # basename needs xargs. 
  # echo $i | cut -d\- -f1,2,3 # for reference 
  DATE=`echo $i | xargs basename | awk -F"-" '{print $1 "/" $2 "/" $3}'`
  echo "$DATE $VALUES"
done | uniq > "$LOCPLOT"
