#!/bin/bash

cmd=$(upower -i $(upower -e | grep -i bat) | grep percentage | cut -d: -f2 | xargs)

time=$(date +%F\ %l:%M\ %p)

notify-send "Battery: ${cmd}
Time: ${time}"
