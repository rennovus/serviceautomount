#!/bin/bash
echo "Detaching Mounted Network Drives!"
/bin/fusermount -uz "$HOME"/cloud/mount
/bin/fusermount -uz "$HOME"/cloud/mount01
/bin/fusermount -uz "$HOME"/cloud/mount02
