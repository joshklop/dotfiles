#!/bin/sh

echo "Starting locker"

echo "Muting audio"
amixer set Master mute

echo "Pausing music"
playerctl pause

slock

echo "Unmuting audio"
amixer set Master unmute
