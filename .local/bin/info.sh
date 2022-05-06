#!/bin/bash

cmd=$(upower -i $(upower -e | grep -i bat) | awk '$1 ~ /percentage/ { print $2 }')
state=$(upower -i $(upower -e | grep -i bat) | awk '$1 ~ /state/ { print $2 }')

if [[ "$state" == 'discharging' ]]; then
    state='unplugged'
else
    state='charging'
fi

time=$(date +%F\ %l:%M\ %p)

notify-send "Battery: ${cmd} ${state}
Time: ${time}"
