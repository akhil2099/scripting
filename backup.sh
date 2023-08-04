#!/bin/bash

alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[00m"
date="$(date +\%d-\%m-\%Y_%H-%M-%s)"

sudo tar -zcpf /var/backups/akhil-$date.tar.gz /home/akhil

if [[ ! -f /var/backups/akhil-$date.tar.gz ]]; then

    echo -e $warning backup failed $nocolour
    echo "Backup failed on $date." | mail -s "Backup Failed" akhil

else

    echo -e $success backup successful $nocolour 
    echo "Backup successful on $date." | mail -s "Backup Successful" akhil

fi
