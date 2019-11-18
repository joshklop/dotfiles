#!/bin/bash

sudo systemctl stop dhcpcd.service
sudo systemctl disable dhcpcd.service
sudo rm -f /var/lib/dhcpcd/*.lease
sudo rm -f /etc/netctl/wlo1*
echo "REBOOT THE SYSTEM TO APPLY CHANGES"
