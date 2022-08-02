#!/bin/bash

sudo apt update -y && sudo apt upgrade -y && sudo apt autoclean -y && \
sudo apt install -y zip unzip python3-pip nodejs npm rclone fuse mergerfs make python build-essential && \
sudo git clone https://github.com/rennovus/sbxn-serviceautomount.git && \
mkdir -p "$HOME"/.start "$HOME"/.stop "$HOME"/cloud/mount/ "$HOME"/scripts && \
cd sbxn-serviceautomount && \
mv rclone-start.sh /usr/local/bin/ && \
mv rclone-stop.sh /usr/local/bin/ && \
mv rclone-mount.service /etc/systemd/system/ && \
mv rclone-mount.env /etc/systemd/system/ && \
chmod +x /usr/local/bin/rclone-start.sh /usr/local/bin/rclone-stop.sh && \
echo -en "\n\n**Required files installed**\n\n" && \
read -n 1 -s -r -p "Press any key to continue" && \
echo -en "\n\nEnable APIs and Create Your Service Accounts...\n\nhttps://github.com/rennovus/sbxn-serviceautomount#-enable-google-apis\n\n" && \
read -n 1 -s -r -p "Press any key to continue"
