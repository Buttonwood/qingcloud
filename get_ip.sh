#!/bin/bash
NUM=`qingcloud iaas describe-instances --status running |grep total_count |awk -F ":" '{print $2;}' |sed 's/^ //'`
IND=0
while [ $IND -le $NUM ];
do
    cmd="qingcloud iaas describe-instances --status running -L 100 -O $IND |perl get_ip.pl -"
    echo $cmd
    IND=$(($IND+100))
done
