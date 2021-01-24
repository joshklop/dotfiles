#!/bin/sh

BACKUP="$HOME/documents/bw.json"

function force(){
  while true; do
    if $1; then
      break
    fi
  done
}

force "bw login" \
  && force "bw export --format json --output $BACKUP" \
  && bw logout \
  && gpg --encrypt --sign --recipient joshklop10@gmail.com $BACKUP \
  && rm $BACKUP
