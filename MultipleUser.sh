#!/bin/bash
alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[00m"

if [[ $EUID -eq 0 ]];then
    if [[ -d /var/userlist ]];then
        echo -e $alert File already exist $nocolour
    else
        touch /var/userlist
        vim useradd.txt
        username=$( cat useradd.txt | tr 'A-Z' 'a-z' )
   
        for user in $username
        do 
            useradd -m $user
            password=$( cat /dev/urandom | tr -dc [:alnum:][:punct:] | fold -w 10 | head -n 1 )
            echo "$user - $password " >> /var/userlist
            cat /var/userlist
        done
    fi
else
    echo -e $warning run in sudo privilage $nocolour
fi