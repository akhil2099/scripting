#!/bin/bash

alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[00m"

if [[ -d /home/akhil/Downloads/Web ]];then
echo -e $alert Directory exists $nocolour
else
mkdir -p /home/akhil/Downloads/Web
echo -e $success Directory created $nocolour
fi

if [[ -f /home/akhil/Downloads/Web/bootstrap/bootstrap-4.0.0-dist.zip ]];then
echo -e $warning File already exist $nocolour
else
wget https://github.com/twbs/bootstrap/releases/download/v4.0.0/bootstrap-4.0.0-dist.zip -o /home/akhil/Downloads/Web/bootstrap/bootstrap-4.0.0-dist.zip
echo -e $success File Downloaded successfully $nocolour
fi


if [[ /home/akhil/Downloads/Web/bootstrap ]];then
 echo -e $warning Bootstrap Directory already exist $nocolour
else
mkdir home/akhil/Downloads/Web/bootstrap
fi

if [[ -f /home/akhil/Downloads/Web/bootstrap/* ]]; then
    echo -e $warning File already extracted $nocolour
else
    unzip -d /home/akhil/Downloads/Web/bootstrap bootstrap-4.0.0-dist.zip
fi
