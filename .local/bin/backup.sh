#!/bin/sh

mounted='n'
while [[ $mounted =~ [^yY] ]]; do
  read -p 'Is your flash drive mounted? [y/N] ' resp
  mounted=$resp
done

bwbackup.sh && borgbackup.sh

echo
echo 'Make sure you umount!'
