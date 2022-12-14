<div align="center">

# SERVICE AUTOMOUNT

<pre>
"Automatically Rclone Mount Shared Drives with Randomized Service Account Files."
</pre>

<img alt="Service Automount License" src="https://img.shields.io/github/license/rennovus/serviceautomount"/>
<img alt="Service Automount Last Commit" src="https://img.shields.io/github/last-commit/rennovus/serviceautomount">
<img alt="Service Automount Repo Size" src="https://img.shields.io/github/repo-size/rennovus/serviceautomount">
<img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Frennovus%2Fserviceautomount&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=views&edge_flat=false"/>

<hr/>
</div>

## 🌠 Features

- Uses Random Service Accounts
- Rclone Union Compatible
- Auto Mount After Reboot via systemd
- Bypass 750GB Transfer Limit

## ⚙️ Requirements
- Linux Server
- Google Shared Drive (Manager Permissions)
- Google APIs & Libraries
- Python3
- Rclone
- Fuse

## 📤 Install

### Python3

If Python3 is not installed run this script
```sh
sudo apt-get update -y && \
sudo apt-get install -y software-properties-common && \
sudo add-apt-repository ppa:deadsnakes/ppa && \
sudo apt-get update -y && \
sudo apt-get install -y python3.9 python3-venv python3-pip && \
sudo python3 -m pip install testresources && \
sudo python3 -m pip install -y --upgrade httplib2
```

If Python3 is installed make sure you have all the extras
```sh
sudo apt-get update -y && \
sudo apt-get install -y python3-venv python3-pip && \
sudo python3 -m pip install testresources && \
sudo python3 -m pip install --upgrade httplib2
```

### Rclone & Fuse

```sh
sudo apt-get update -y && \
sudo apt-get install -y rclone fuse mergerfs
```

Edit `fuse.conf` file and delete the `#` from `#user_allow_other`
```sh
sudo nano /etc/fuse.conf
```

### Service Automount

```sh
sudo apt-get update -y && sudo apt-get install -y git && \
mkdir -p ~/scripts ~/cloud/mount ~/cloud/mount01 ~/cloud/mount02 && \
git clone https://github.com/rennovus/serviceautomount.git && \
cd serviceautomount && \
mkdir -p accounts && \
sudo mv rclone-start.sh /usr/local/bin/ && \
sudo mv rclone-stop.sh /usr/local/bin/ && \
sudo mv rclone-mount.service /etc/systemd/system/ && \
sudo mv rclone-mount.env /etc/systemd/system/ && \
sudo chmod +x /usr/local/bin/rclone-start.sh /usr/local/bin/rclone-stop.sh && \
sudo pip3 install -r requirements.txt
```

## 🔑 Enable Google APIs

### Drive API

1. Visit https://developers.google.com/drive/api/v3/quickstart/python
2. Enter a Project Name OR Skip
3. Configure your OAuth Client > Desktop App
4. Create

**IMPORTANT:** Rename the file to `credentials.json` and place it in the `serviceautomount` repository folder

#### To Enable the below two APIs, `visit the link > select the Project > Enable`

![iam-googleapis](https://i.imgur.com/hJP61iq.png)

### Identity and Access Management (IAM) API
[iam.googleapis.com](https://console.developers.google.com/apis/library/iam.googleapis.com)

### Service Usage API
[serviceusage.googleapis.com](https://console.developers.google.com/apis/library/serviceusage.googleapis.com)

## 🤖 Generate Service Accounts

### Create New Project with Service Accounts
*NOTE: Authenticate using the same account that created the `credentials.json` file*
```sh
sudo python3 gen_sa_accounts.py --quick-setup 2 --new-only
```

### List Existing Projects
*NOTE: If you already have Service Account Keys and don't want to create new ones use the commands below:*
```sh
sudo python3 gen_sa_accounts.py --list-projects
```

### Download Existing Service Account Files from Project
```sh
sudo python3 gen_sa_accounts.py --download-keys PROJECTID
```

### Add Permissions for Service Accounts to access the SHAREDRIVE folder

#### Option #1

```sh
sudo python3 add_to_team_drive.py -d SHAREDRIVEID
```
Replace `SHAREDRIVEID` with your `Shared Drive ID`

![](https://i.imgur.com/53g521H.png)

#### Option #2 (Personally Easier Shared Drive Permission Management)

1. Create a [Google Group](https://groups.google.com) email for your Service Accounts
2. Go to https://console.cloud.google.com
3. Choose your Service Account project `saf-XXXXX`
4. Under the IAM & Admin settings choose Service Accounts
5. Adjust the column settings and number of rows
6. Export the table (Google Docs Spreadsheet)
7. Filter the emails and import them into your Google Group email
8. Add the Google Group email to your `Shared Drive` as a Content Manager

*NOTE: Google Groups only allow 100 emails imported per 24 hours. I think there was a way around it but I don't remember.*

Change ownership of the `accounts` folder and move it to the `scripts` folder
```sh
sudo chown -R $USER:$USER accounts && \
mv accounts ~/scripts/
```

## 🔧 Configuration

### Rclone

Configure your Rclone installation to fit your needs (encryption, union, etc.) https://rclone.org/drive/

```sh
rclone config
```

#### Rclone Mount Start

Edit the start file to fit your rclone config settings and mounts
```sh
sudo nano /usr/local/bin/rclone-start.sh
```

#### Rclone Mount Stop

Edit the stop file to unmount your rclone drives
```sh
sudo nano /usr/local/bin/rclone-stop.sh
```

### Service and Environment

Update environment variables based on the `rclone-start.sh` file
```sh
sudo nano /etc/systemd/system/rclone-mount.env
```

Get your UID and GID
```sh
id
```

Update the User and Group to match your UID and GID
```sh
sudo nano /etc/systemd/system/rclone-mount.service
```

#### Service Enable and Start
```sh
sudo systemctl enable rclone-mount.service && \
sudo systemctl start rclone-mount.service
```

#### Service Status
```sh
sudo systemctl status rclone-mount.service
```

## Complete

### Test

1. Navigate to rclone mount directory and list files/folders
2. Create a new folder and check your Google Drive to see if it was created
3. Reboot server and check `systemctl status rclone-mount.service`
4. Every time you reboot the machine or restart the service it will use a new random service account file

### Common Issues

1. Make sure your rclone-start.sh and rclone-stop.sh files are executable `chmod +x`
2. Check your folder paths locally and inside the rclone-start.sh file `/usr/local/bin/rclone-start.sh`
3. Double check your quotes when using the rclone union method inside the `rclone-start.sh` file
4. Make sure that the `fuse.conf` file is setup correctly to allow other users
5. Still having trouble? Try stopping the service and manually running the rclone-start.sh script
6. Join our [Discord](https://discord.gg/5WygmaE6a7) for more help

### Remove Install Files
```sh
sudo rm -rf ~/serviceautomount
```

You can take the files and folders you created to any server and get rclone setup quickly.
1. Install rclone, fuse, and mergerfs
2. Edit the fuse.conf file
3. Create the mount directories
4. Copy the necessary files/folders (rclone-mount.service, rclone-mount.env, rclone-start.sh, rclone-stop.sh, rclone.conf and the scripts folder)
5. Enable the rclone-mount.service file
6. Done

## Credits

[alx-xlx/gdrive-clone](https://github.com/alx-xlx/gdrive-clone) - Requirements and Generate Service Accounts
