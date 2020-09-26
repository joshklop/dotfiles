#!/bin/sh

repos=($HOME/code/* $HOME/cyberpatriot)

# This StackOverflow answer helped with the colors
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
MAIN='\033[1;34m'
RED='\033[0;31m'
NC='\033[0m'  # No color

echo
for i in "${repos[@]}"; do
  if [ -d $i/.git ]; then
    echo -e "${MAIN}$i${NC}"
    behind=`git -C $i rev-list --left-right --count origin/master...master | cut -f 1`
    ahead=`git -C $i rev-list --left-right --count origin/master...master | cut -f 2`
    echo -e "master is ${RED}$ahead${NC} commits ahead and ${RED}$behind${NC} commits behind origin/master."
    git -C $i st -s
    echo
  fi
done
