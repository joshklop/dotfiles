#!/bin/sh

echo "Starting locker"

echo "Muting audio"
amixer set Master mute

echo "Pausing music"
playerctl pause

echo "locking screen" \
        &&  i3lock \
                --ignore-empty-password \
                --nofork \
                --show-failed-attempts \
                --indicator \
                --clock \
                --color=313030ff \
                --insidecolor=807369ff \
        && echo "unlocking"

echo "Unmuting audio"
amixer set Master unmute
