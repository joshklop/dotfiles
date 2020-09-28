#!/bin/sh

sudo systemctl stop dhcpcd.service
sudo systemctl disable dhcpcd.service
sudo rm -f /var/lib/dhcpcd/*.lease
sudo rm -f /etc/netctl/wlo1*
sudo systemctl restart netctl
sudo systemctl enable netctl
sudo rfkill unblock all
sudo wifi-menu -o
