#!/bin/bash
source /script/crc16.bash
#ifconfig eth0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'
mac=`/sbin/ifconfig eth0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | sed 's/://g'`
#echo $mac
crc16 $mac
#crc16 $res
echo $res