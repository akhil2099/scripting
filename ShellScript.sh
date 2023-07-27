#!/bin/bash

alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[00m"

if [[ -d /home/akhil/Downloads/Web ]];then
echo -e $alert directory exists $nocolour
else
mkdir -p /home/akhil/Downloads/Web
echo -e $success Directory created $nocolour
fi

if [[ -f /home/akhil/Downloads/Web/latest.zip ]];then
echo -e $warning file already exist $nocolour
else
wget https://wordpress.org/latest.zip -o /home/akhil/Downloads/Web/latest.zip
echo -e $success file Downloaded successfully $nocolour
fi
