#!/bin/bash

dirct="/sbkl/temp/"
fil="gps.txt"

#timeout 50 cat /dev/ttyUSB0 | grep GPRMC | grep N | grep -v V | head -n 3 >> $dirct$fil
timeout 50 cat /dev/ttyUSB0 | grep GPRMC | grep N | grep -v V | head -n 2 >> $dirct$fil
signal=`z_atS0 AT+CSQ | awk '{print $3}'`;
network=`z_atS0 AT+COPS? | awk '{print $3}' | awk -F ',' '{print $3}'`; 
#получаем текущую сеть оператора
rouming=`z_atS0 AT+CREG? | awk '{print $3}'`;
echo -e "$signal\t$network\t$rouming\tEND" >> $dirct$fil
#sleep 1;
#killall cat;
