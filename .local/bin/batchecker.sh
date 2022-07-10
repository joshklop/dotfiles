#!/bin/bash

while true; do
  bat=$(upower -i $(upower -e | grep -i bat) | grep percentage | cut -d ':' -f 2 | xargs)
  state=$(upower -i $(upower -e | grep -i bat) | grep state | cut -d ':' -f 2 | xargs)
  bat=${bat%\%}
  msg="WARNING: battery charge is $bat%"
  if [[ "$bat" -le 10 && "$state" != "charging" ]]; then
    notify-send --urgency="critical" "$msg"
  elif [[ "$bat" -ge 90 && "$state" == "charging" ]]; then
    notify-send --urgency="critical" "$msg"
  fi
  sleep 150;
done
