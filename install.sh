#!/bin/bash
################################################################################
# Automation Script for Rclone
#
#   I am a hobbyist not a developer.
#   Have suggestions hit me up!
#   Discord XanderSlaze#0001
#   https://discord.gg/5WygmaE6a7
#   Updated: 8/1/2022
################################################################################

sudo apt update -y && sudo apt upgrade -y && sudo apt autoclean -y && \
sudo apt-get install -y software-properties-common && \
sudo add-apt -repository ppa:deadsnakes/ppa && \
sudo apt-get update && \
sudo apt install -y zip unzip python3.8 python3-pip rclone fuse mergerfs build-essential && \
sudo git clone https://github.com/rennovus/sbxn-serviceautomount.git && \
mkdir -p `pwd`/sbxn-serviceautomount/accounts `pwd`/cloud/mount/ `pwd`/scripts && \
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
