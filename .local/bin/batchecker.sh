#!/bin/bash

while true; do
  bat=$(upower -i $(upower -e | grep -i bat) | grep percentage | cut -d ':' -f 2 | xargs)
  bat=${bat%\%}
  if [[ $bat -le 10 ]]; then
    notify-send --urgency="critical" "WARNING: battery charge is <= 10%"
  elif [[ $bat -ge 90 ]]; then
    notify-send --urgency="critical" "WARNING: battery charge is >= 90%"
  fi
  sleep 120;
done
