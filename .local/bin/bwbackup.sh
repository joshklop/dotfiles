#!/bin/sh

backup="$HOME/Documents/bw.json"

bw login \
  && bw export --format json --output $backup \
  && bw logout \
  && gpg --encrypt --sign $backup \
  && rm $backup
