#!/bin/bash

Network=192.168.0.
StartPort=1
EndPort=1024

# yum install nc
# apt-get install nc

Count=0
while [ $Count -ne 256 ]
do
	echo -e -n $Network$Count'\r'
   ping -W 1 -c 1 $Network$Count &>/dev/null
   if [ $? -eq 0 ]
   then
      PortCount=$StartPort
      while [ $PortCount -ne $(($EndPort+1)) ]
      do
         nc -w 1 $Network$Count $PortCount < /dev/null > /dev/null
         if [ $? -eq 0 ]
         then 
            echo -n $Network$Count':'$PortCount
            echo ''
         fi
      	PortCount=$(($PortCount+1))
      done
   fi
	Count=$(($Count+1))
done
