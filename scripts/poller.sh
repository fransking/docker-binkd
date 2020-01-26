#!/bin/sh
if [ -f "$1" ] # checking if file exist
then 
 while read line
 do
   echo "Polling $line"
   /binkd/binkd -p -P "$line" /binkd/binkd.conf
 done <"$1" # double quotes important to prevent word splitting
else
  echo "Uplinks file $1 doesn't exist"
fi