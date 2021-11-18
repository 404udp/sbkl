#!/bin/bash
AT="$1"
TTY="/dev/ttyS0"
SLEEP=4
RESULT=$(cat $TTY & echo -e "$AT\r" > $TTY; sleep $SLEEP; kill %cat)
#echo "\r +"
echo $RESULT
#echo "OKKO"
#echo $RESULT
#echo "OK!!!"
