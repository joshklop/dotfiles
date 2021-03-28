#!/bin/sh

brightness="/sys/class/backlight/intel_backlight/brightness"
current=$(cat $brightness)
if [[ $1 = "+" ]]; then
  let "new = $current + 1000"
  echo $new > $brightness
elif [[ $1 = "-" ]]; then
  let "new = $current - 1000"
  echo $new > $brightness
fi
