#!/bin/bash
echo "Detaching Mounted Network Drives!"
# Add your rclone mounts
#/bin/fusermount -uz $HOME/cloud/mount
/bin/fusermount -uz $HOME/cloud/mount01
/bin/fusermount -uz $HOME/cloud/mount02
