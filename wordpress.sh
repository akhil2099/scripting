#!/bin/bash

alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[00m"


if [[ -f /home/akhil/Downloads/latest.zip ]];then
echo -e $alert File exists $nocolour
elif [[ ! -f /home/akhil/Downloads/latest.zip ]];then
echo -e $alert Do you want to install wordpress yes[Y], no[N] $nocolour
read answer
    if [[ $answer == Y ]];then
    wget https://wordpress.org/latest.zip -o /home/akhil/Downloads/latest.zip
    echo -e $success File Downloaded successfully $nocolour
    else
    echo -e $warning Installation Aborted $nocolour
    fi
else
    exit    
fi


if [[ -f /home/akhil/Downloads/latest.zip ]]; then
    unzip -q -d /var/www/html/ latest.zip
    echo -e $success Extraction Successful $nocolour
else
   echo -e $error unzip failed $nocolour
fi


if [[ -d /var/www/html/wordpress ]];then
sudo chmod -R 750 /var/www/html/wordpress
echo -e $success File permission granted $nocolour
else
echo -e $error File permission rejected $nocolour
fi

