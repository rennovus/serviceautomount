#!/bin/bash
################################################################################
# Automation Script for Rclone
#   If you need help join the Discord https://discord.gg/5WygmaE6a7
#   Updated: 8/5/2022
################################################################################


###########################################################
## // GET AND SAVE SERVICE ACCOUNT FILEPATH AS VARIABLES ##
###########################################################

## Create as many variables as you need for your solution
## These variables will go to your service accounts folder and choose a random file
SA1=$(find $HOME/scripts/accounts/* -type f | shuf -n1)
SA2=$(find $HOME/scripts/accounts/* -type f | shuf -n1)

## Save the file path output as another variable
SERVICE01=${SA1}
SERVICE02=${SA2}

###########################################################
## \\ GET AND SAVE SERVICE ACCOUNT FILEPATH AS VARIABLES ##
###########################################################

###############################
## // CHOOSE YOUR MOUNT TYPE ##
###############################

## Going forward I will assume you are NOT going to use the union setup

## Rclone Mount Folders
MOUNT01=$HOME/cloud/mount01/
MOUNT02=$HOME/cloud/mount02/

## Rclone Union Mount Folder
#MOUNT_DIR=$HOME/cloud/mount

###############################
## \\ CHOOSE YOUR MOUNT TYPE ##
###############################

############################
## // DIRECTORY VARIABLES ##
############################

CACHE_DIR=$HOME/.cache/rclone
SCRIPTS_DIR=$HOME/scripts
############################
## \\ DIRECTORY LOCATIONS ##
############################

#######################################################
## //THIS CODE IS ONLY FOR RCLONE UNION MULTIPLE MOUNTS
#######################################################

## This will remove the rclone.conf file and replace it with a new one
## The new rclone.conf file will have brand new service accounts

## This is the code from your rclone.conf file. Remove all returns and replace
## it with "\n" the goal is to recreate the original rclone.conf file exactly.
## Also, be sure to add a backslash (\) before any quotes (\"TEXT\").
## If you know a better way please let me know!

#rm $HOME/.config/rclone/rclone.conf
#echo -en "[gdrive]\ntype = drive\nconfig_is_local = false\nclient_id = CLIENT_ID_GOES_HERE\nclient_secret = CLIENT_SECRET_GOES_HERE\nscope = drive\ntoken = {\"access_token\":\"ACCESS_TOKEN_GOES_HERE\",\"token_type\":\"Bearer\",\"refresh_token\":\"1//REFRESH_TOKEN_GOES_HERE\",\"expiry\":\"2022-04-03T09:53:26.85232755-05:00\"}\n\n[gcrypt]\ntype = crypt\nfilename_encryption = standard\nremote = gdrive:encrypt\ndirectory_name_encryption = true\npassword = PASSWORD\npassword2 = PASSWORD2\n\n[gunion]\ntype = union\nupstreams = crypt-mount01: crypt-mount02:\n\n[mount01]\ntype = drive\nscope = drive\nteam_drive = DRIVE_FOLDER\nservice_account_file = $SERVICE01\n\n[mount02]\ntype = drive\nscope = drive\nteam_drive = DRIVE_FOLDER\nservice_account_file = $SERVICE02\n\n[crypt-mount01]\ntype = crypt\nremote = mount01:encrypt\nfilename_encryption = standard\ndirectory_name_encryption = true\npassword = PASSWORD\npassword2 = PASSWORD2\n\n[crypt-mount02]\ntype = crypt\nremote = mount02:encrypt\nfilename_encryption = standard\ndirectory_name_encryption = true\npassword = PASSWORD\npassword2 = PASSWORD2" >> "$HOME/.config/rclone/rclone.conf"

#################################
## \\RCLONE UNION MULTIPLE MOUNTS
#################################

CONFIG_FILE=$HOME/.config/rclone/rclone.conf

################################
## // MOUNT THE RCLONE DRIVES ##
################################

## I will assume you are NOT using Rclone Union and have a separate server for Plex

# ------------------------------------------------------------------------------
# Rclone Mount (Read/Write)

/usr/bin/rclone mount crypt-drive01: ${MOUNT01} --allow-other --allow-non-empty --cache-db-purge --timeout 1h --vfs-cache-mode full --vfs-cache-max-age 72h --vfs-cache-max-size 128G --cache-dir ${CACHE_DIR} --config=${CONFIG_FILE} --drive-service-account-file ${SERVICE01} &

# ------------------------------------------------------------------------------
# Rclone Mount (Read/Write)

#/usr/bin/rclone mount crypt-drive02: ${MOUNT02} --allow-other --allow-non-empty --cache-db-purge --timeout 1h --vfs-cache-mode full --vfs-cache-max-age 72h --vfs-cache-max-size 128G --cache-dir ${CACHE_DIR} --config=${CONFIG_FILE} --drive-service-account-file ${SERVICE02} &

# ------------------------------------------------------------------------------
# Plex Server Rclone Mount (Read Only)

#/usr/bin/rclone mount crypt-drive01: ${MOUNT01} --allow-other --allow-non-empty --cache-db-purge --timeout 1h --vfs-cache-mode full --vfs-cache-max-age 72h --vfs-cache-max-size 128G --vfs-read-ahead 2G --vfs-cache-poll-interval 5m --poll-interval 30s --buffer-size 256M --use-mmap --transfers 8 --tpslimit 10 --tpslimit-burst 10 --drive-pacer-min-sleep 50ms --drive-pacer-burst 200 --cache-dir ${CACHE_DIR} --config=${CONFIG_FILE} --drive-service-account-file ${SERVICE01} &

#/usr/bin/rclone mount crypt-drive02: ${MOUNT02} --allow-other --allow-non-empty --cache-db-purge --timeout 1h --vfs-cache-mode full --vfs-cache-max-age 72h --vfs-cache-max-size 128G --vfs-read-ahead 2G --vfs-cache-poll-interval 5m --poll-interval 30s --buffer-size 256M --use-mmap --transfers 8 --tpslimit 10 --tpslimit-burst 10 --drive-pacer-min-sleep 50ms --drive-pacer-burst 200 --cache-dir ${CACHE_DIR} --config=${CONFIG_FILE} --drive-service-account-file ${SERVICE02} &

# ------------------------------------------------------------------------------
# Rclone Union Mount (Read/Write)

#/usr/bin/rclone mount gunion: ${MOUNT_DIR} --allow-other --allow-non-empty --cache-db-purge --timeout 1h --vfs-cache-mode full --vfs-cache-max-age 72h --vfs-cache-max-size 128G --vfs-read-ahead 4G --vfs-cache-poll-interval 5m --poll-interval 30s --buffer-size 256M --use-mmap --transfers 8 --cache-dir ${CACHE_DIR} --config=${CONFIG_FILE} &

# ------------------------------------------------------------------------------
# Plex Server Rclone Union Mount (Read Only)

#/usr/bin/rclone mount gunion: ${MOUNT_DIR} --allow-other --allow-non-empty --cache-db-purge --timeout 1h --vfs-cache-mode full --vfs-cache-max-age 72h --vfs-cache-max-size 128G --vfs-read-ahead 4G --vfs-cache-poll-interval 5m --poll-interval 30s --buffer-size 256M --use-mmap --transfers 8 --tpslimit 10 --tpslimit-burst 10 --drive-pacer-min-sleep 50ms --drive-pacer-burst 200 --cache-dir ${CACHE_DIR} --config=${CONFIG_FILE} &

################################
## \\ MOUNT THE RCLONE DRIVES ##
################################
