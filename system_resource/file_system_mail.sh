#!/bin/bash

export PATH=/usr/local/bin:/usr/bin:/bin
export LANG=en_US.UTF-8

# the variable contain command to display the C & D drive space
file1=$(/bin/df -H | grep "drvfs" | awk 'NR==1{print$5}' | tr -d %)
file2=$(/bin/df -H | grep "drvfs" | awk 'NR==2{print$5}' | tr -d %)

# here you have to provide your email address
to="provide your email"

MAIL=/usr/bin/mail

# path where log file is created
LOG_FILE="your log file path"

if [[ $file1 -ge 80 ]] ||  [[ $file2 -ge 80 ]]
then
	echo -e "WARNING!!!! Disk Space Is Low , Time for some cleaning\nC-Drive = $file1%\nD-Drive = $file2%" | $MAIL -s "Disk space alert" $to
else
	echo -e "All GOOD.....\nC-Drive = $file1%\nD-Drive = $file2%" | $MAIL -s "Disk Space Alert" $to
fi

echo "$(date): script excecuted" >> $LOG_FILE 2>&1
