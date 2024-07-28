#!/bin/bash

source /etc/lsb-release

if [[ "$DISTRIB_ID" -ne "Ubuntu" ]]; then
  echo "No action taken..."
  echo "Are you sure this is an Ubuntu system?"
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
  echo "No action taken..."
  echo "This script must be run as root"
  exit 1
fi

read -p "Enter desired hostname: " newHostname

echo "Generating new Machine ID"
rm -f /var/lib/dbus/machine-id
rm -f /etc/machine-id
dbus-uuidgen --ensure=/etc/machine-id
ln -s /etc/machine-id /var/lib/dbus/

echo "Setting Hostname"
sed -i "s/$HOSTNAME/$newHostname/g" /etc/hosts
sed -i "s/$HOSTNAME/$newHostname/g" /etc/hostname
hostnamectl set-hostname $newHostname

echo "Done!"

read -p "Would you like to reboot the system now? [Y/N]: " confirm &&
  [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

reboot
exit 0