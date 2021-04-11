#!/usr/bin/env bash

USERNAME=${1:-""}
PASSWORD=${2:-""}
HOME_VOLUME_SIZE=${3:-"50G"}
DATA_VOLUME_SIZE=${4:-"100G"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e "Script must be run as root. Use sudo or su."
    exit 1
fi

HOME_VL=home-${USERNAME}
DATA_VL=data-${USERNAME}

echo "Creating logical volumes for users."

if lvs /dev/ubuntu-vg/${HOME_VL}; then
    echo "User's home lv already exists, skipping."
else
    # Create home lv from ubuntu-vg
    lvcreate -L ${HOME_VOLUME_SIZE} -n ${HOME_VL} ubuntu-vg
    # Format both lv as ext4
    echo "Formatting home volume."
    mkfs.ext4 /dev/ubuntu-vg/${HOME_VL}
fi

if lvs /dev/data-vg/${DATA_VL}; then
    echo "User's data lv alreaday exists, skipping"
else
    # Create data lv from data-vg
    lvcreate -L ${DATA_VOLUME_SIZE} -n ${DATA_VL} data-vg
    echo "Formatting data volumes."
    mkfs.ext4 /dev/data-vg/${DATA_VL}
fi

echo "Creating user"
# Create user
useradd -s /bin/bash -p $(openssl passwd -1 ${PASSWORD}) ${USERNAME}
# Create home directory
mkdir -p /home/${USERNAME}
# Mount home lv
mount /dev/ubuntu-vg/${HOME_VL} /home/${USERNAME}
# Create dat directory
mkdir -p /home/${USERNAME}/data
# Mount data lv
mount /dev/data-vg/${DATA_VL} /home/${USERNAME}/data
# Copy template to home
cp -RT /etc/skel /home/${USERNAME}
# Change owner
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}
# Change permission
chmod 0750 /home/${USERNAME}

# Auto mount
echo "/dev/ubuntu-vg/${HOME_VL} /home/${USERNAME} ext4 defaults 0 0" >> /etc/fstab
echo "/dev/data-vg/${DATA_VL} /home/${USERNAME}/data ext4 defaults 0 0" >> /etc/fstab

# Finish
echo "Done!"
