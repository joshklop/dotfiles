#!/bin/bash

# This StackOverflow answer helped with the colors
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
PREFIX='\033['
BLUE="${PREFIX}1;34m"
RED="${PREFIX}0;31m"
RESET="${PREFIX}0m"  # No color

echo
for i in $HOME/repos/*/; do
  if [[ -d $i/.git ]]; then
    echo -e "${BLUE}$i${RESET}"
    behind=$(git -C $i rev-list --left-right --count origin/master...master | cut -f 1)
    ahead=$(git -C $i rev-list --left-right --count origin/master...master | cut -f 2)
    echo -e "master is ${RED}$ahead${RESET} commits ahead and ${RED}$behind${RESET} commits behind origin/master."
    git -C $i s -s
    echo
  fi
done
