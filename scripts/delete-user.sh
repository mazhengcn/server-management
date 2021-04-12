#!/usr/bin/env bash

USERNAME=${1:-""}
KEEP_DATA=${2:-"false"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e "Script must be run as root. Use sudo or su."
    exit 1
fi

HOME_VL=home-${USERNAME}
DATA_VL=data-${USERNAME}


# Umount user home and data directory.
echo "Unounting user's data and home directory."
umount /home/${USERNAME}/data
umount /home/${USERNAME}

echo "Checking logical volumes"

if lvs /dev/ubuntu-vg/${HOME_VL}; then
    echo "User's home lv found, deleting."
    lvremove /dev/ubuntu-vg/${HOME_VL}
else
    echo "Can't find user logical volume, skipping."  
fi

if lvs /dev/data-vg/${DATA_VL}; then
    echo "User's data lv found."
    if ${KEEP_DATA}; then
        echo "Choose to keep user's data volume, skip deleting."
    else
        echo "Deleting user's data volume."
        lvremove /dev/data-vg/${DATA_VL}
    fi
else
    echo "Can't find user logical volume, skipping."
fi

echo "Deleting user"
# Delete user
userdel -f -r ${USERNAME}

# Delete auto mount
echo "Delete auto mount in fstab."
sed -i "/${USERNAME}/d" /etc/fstab

# Finish
echo "Done!"
