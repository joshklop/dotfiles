#!/bin/sh

BACKUP="$HOME/documents/bw.json"

bw login \
  && bw export --format json --output $BACKUP \
  && bw logout \
  && gpg --encrypt --sign --recipient joshklop10@gmail.com $BACKUP \
  && rm $BACKUP
