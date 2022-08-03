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

sudo apt-get update -y && \
sudo apt-get install -y software-properties-common && \
sudo add-apt-repository ppa:deadsnakes/ppa && \
sudo apt-get update -y && \
sudo apt-get install -y python3.9 python3-pip rclone fuse mergerfs && \
mkdir -p accounts && \
mv rclone-start.sh /usr/local/bin/ && \
mv rclone-stop.sh /usr/local/bin/ && \
mv rclone-mount.service /etc/systemd/system/ && \
mv rclone-mount.env /etc/systemd/system/ && \
chmod +x /usr/local/bin/rclone-start.sh /usr/local/bin/rclone-stop.sh
