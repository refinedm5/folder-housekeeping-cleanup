#!/bin/bash
workdir="/opt/tomcat/logs"
logfile="/mnt/log/admin/housekeeping.log"
targetdir="/mnt/log/"
startime=$(date)
echo "========================================================================" >> $logfile
echo "archiving compressed catalina.out on $startime" >> $logfile
for y in `find $workdir -type f -mmin +60 -name "catalina.out*gz"`
do
echo "archiving $y to /mnt/log/" >> $logfile
echo "$y"
cp --preserve $y $targetdir
statx=$?
if [ $statx -eq 0 ]
        then
                echo "..completed" >> $logfile
                echo "cleaning up $y" >> $logfile
                rm $y
                staty=$?
                if [ $staty -eq 0 ]
                then
                        echo "..completed" >> $logfile
                else
                        echo "can't clean $y, something went wrong" >> $logfile
                fi
        else
                echo "failed to archive $y, something went wrong" >> $logfile
fi
done
endtime=$(date)
echo "Housekeeping on $endtime has been completed" >> $logfile
echo "========================================================================" >> $logfile

