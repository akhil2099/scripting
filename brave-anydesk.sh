#!/bin/bash

if [[ $EUID -eq 0 ]]; then
    read -p "Do you want to install Brave Browser and AnyDesk in your system? (YES[Y]/NO[N]): " answer
    if [[ $answer =~ ^[Yy]$ ]]; then

        log_file="/var/log/.installation.log"

        loading_message="Downloading Brave Browser And Anydesk In Your System"

        for ((i = 0; i < ${#loading_message}; i++)); do
            echo -n "${loading_message:$i:1}"
            sleep 0.08
        done
        echo

        if ! command -v brave-browser &>/dev/null; then
            if ! command -v curl &>/dev/null; then
                apt -qq install curl
            fi
            curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg >/dev/null
            echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null

            apt -qq update >>$log_file 2>&1
            apt -qq install brave-browser -y >>$log_file 2>&1
            echo "Brave Browser successfully installed"
        else
            echo "Brave Browser is already installed"
        fi

        if ! command -v anydesk &>/dev/null; then
            if ! command -v curl &>/dev/null; then
                apt -qq install curl
            fi
            curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor | sudo tee /usr/share/keyrings/anydesk-archive-keyring.gpg >/dev/null
            echo "deb [signed-by=/usr/share/keyrings/anydesk-archive-keyring.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list >/dev/null

            apt -qq update >>$log_file 2>&1
            apt -qq install anydesk -y >>$log_file 2>&1
            echo "AnyDesk successfully installed"
        else
            echo "AnyDesk is already installed"
        fi

    else
        exit
    fi
else
    echo "Run this script as root"
fi
