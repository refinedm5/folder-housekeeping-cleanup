#!/bin/bash
workdir="/mnt/log"
logfile="/mnt/log/admin/cleanup.log"
targetdir="/mnt/log/"
startime=$(date)
echo "========================================================================" >> $logfile
#set to 3 days, change -mtime +x as required
echo "cleaning up archived files older than 3 days on $startime" >> $logfile
for y in `find $workdir -type f -mtime +2 -name "catalina.out*"`
do
echo "deleting $y..." >> $logfile
rm $y
statx=$?
if [ $statx -eq 0 ]
        then
                echo "..completed" >> $logfile
        else
                echo "failed to delete $y, something went wrong" >> $logfile
fi
done
endtime=$(date)
echo "Cleanup on $endtime has been completed" >> $logfile
echo "========================================================================" >> $logfile
