<div align="center">

# SERVICE AUTOMOUNT

<pre>
"Automatically Mount Rclone Drive(s) with Randomized Service Account Files."
</pre>

<img alt="SBXN Service Automount License" src="https://img.shields.io/github/license/rennovus/sbxn-serviceautomount"/>
<img alt="SBXN Service Automount Release Date" src="https://img.shields.io/github/release-date/rennovus/sbxn-serviceautomount">
<img alt="SBXN Service Automount Last Commit" src="https://img.shields.io/github/last-commit/rennovus/sbxn-serviceautomount">
<img alt="SBXN Service Automount Repo Size" src="https://img.shields.io/github/repo-size/rennovus/sbxn-serviceautomount">
<img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Frennovus%2Fsbxn-serviceautomount&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=views&edge_flat=false"/>

<hr/>
</div>

## 🌠 Features

- Uses Random Service Accounts to Mount Rclone Drive(s)
- Auto Mount After Reboot via systemd
- Bypass 750GB Transfer Limit

## ⚙️ Requirements
- Linux Server
- Google Account
- Google APIs & Libraries
- Python3
- Rclone
- Fuse

## 📤 Install

```sh
sudo apt-get update -y && sudo apt-get install -y git && \
git clone https://github.com/rennovus/sbxn-serviceautomount.git && \
cd sbxn-serviceautomount && \
chmod +x install.sh && \
sudo ./install.sh
```

Edit `fuse.conf` file and uncomment `#user_allow_other`
```sh
sudo nano /etc/fuse.conf
```

## 🔑 Enable Google APIs

### Drive API

1. Visit https://developers.google.com/drive/api/v3/quickstart/python
2. Enter a Project Name OR Skip
3. Configure your OAuth Client > Desktop App
4. Create

Rename the file to `credentials.json` and place it in the repository folder

#### To Enable the below two APIs, `visit the link > select the Project > Enable`

![iam-googleapis](https://i.imgur.com/hJP61iq.png)

### Identity and Access Management (IAM) API
[iam.googleapis.com](https://console.developers.google.com/apis/library/iam.googleapis.com)

### Service Usage API
[serviceusage.googleapis.com](https://console.developers.google.com/apis/library/serviceusage.googleapis.com)

## 🤖 Generate Service Accounts

Install all the required python modules
```sh
cd ~/sbxn-serviceautomount && \
sudo pip3 install -r requirements.txt
```

Create service accounts
```sh
sudo python3 gen_sa_accounts.py --quick-setup 2 --new-only && \
mv accounts ~/scripts/
```

### Add Permissions for Service Accounts to access the TEAMDRIVE folder

### Option #1

```sh
python3 add_to_team_drive.py -d TEAMDRIVEID
```
Replace `TEAMDRIVEID` with your `Teamdrive ID`

![](https://i.imgur.com/53g521H.png)

OR

Replace `TEAMDRIVEID` with `Folder ID` Inside `My Drive` having Editor Permission

![](https://i.imgur.com/hqPT2Jx.png)


This will Add all the service accounts to your Teamdrive, so make sure you have `Manager` Role in this `TEAMDRIVEID`

### Option #2 (Personally Easier TeamDrive Permission Management)

1. Create a [Google Group](https://groups.google.com) email for your Service Accounts
2. Go to https://console.cloud.google.com
3. Choose your Service Account project `saf-XXXXX`
4. Under the IAM & Admin settings choose Service Accounts
5. Adjust the column settings and number of rows
6. Export the table (Google Docs Spreadsheet)
7. Filter the emails and import them into your Google Group email
8. Add the Google Group email to your `TEAMDRIVE` as a Content Manager

#### NOTE: Google Groups only allows 100 emails imported per 24 hours. I think there was a way around it but I don't remember.

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

#### Environment variables are the absolute path to files/folders `(ex. /home/myuser/.../)`
```sh
sudo nano /etc/systemd/system/rclone-mount.env
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
2. Reboot server and check `systemctl status rclone-mount.service`

### Common Issues

1. Make sure your rclone-start.sh and rclone-stop.sh files are executable `chmod +x`
2. Check your folder paths locally and inside the rclone-start.sh file `/usr/local/bin/rclone-start.sh`
3. Double check your quotes when using the rclone union method inside the `rclone-start.sh` file
4. Make sure that the `fuse.conf` file is setup correctly to allow other users

### Remove Install Files
```sh
sudo rm ~/sbxn-serviceautomount
```

You can take the files and folders you created to any server and get rclone setup quickly.
1. Install rclone, fuse, and mergerfs
2. Edit the fuse.conf file
3. Enable the rclone-mount.service file

## Credits

[alx-xlx/gdrive-clone](https://github.com/alx-xlx/gdrive-clone) - Requirements and Generate Service Accounts
