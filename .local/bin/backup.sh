#!/bin/sh

bwbackup.sh && borgbackup.sh

echo
echo 'Make sure you umount!'
