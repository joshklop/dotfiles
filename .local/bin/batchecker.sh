#!/bin/bash

while true; do
  bat=$(upower -i $(upower -e | grep -i bat) | grep percentage | cut -d ':' -f 2 | xargs)
  state=$(upower -i $(upower -e | grep -i bat) | grep state | cut -d ':' -f 2 | xargs)
  bat=${bat%\%}
  if [[ $bat -le 10 && $state != "charging" ]]; then
    notify-send --urgency="critical" "WARNING: battery charge is <= 10%"
  elif [[ $bat -ge 90 && $state == "charging" ]]; then
    notify-send --urgency="critical" "WARNING: battery charge is >= 90%"
  fi
  sleep 300;
done
