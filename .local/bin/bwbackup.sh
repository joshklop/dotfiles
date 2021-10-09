#!/bin/sh

MYVARS="$HOME/.local/bin/bw_env_vars.sh"

gpg --decrypt "$HOME/.local/bin/bw_env_vars.sh.gpg" > "$MYVARS"
chmod +x "$MYVARS"
source "$MYVARS"
rm "$MYVARS"

BACKUP="$HOME/documents/bw.json"

bw logout
if [[ "$?" -ne "0" ]]; then
    echo
fi

bw login --apikey \
  && bw export --format json --output "$BACKUP" \
  && bw logout \
  && gpg --encrypt --sign --recipient joshklop10@gmail.com "$BACKUP" \
  && rm $BACKUP

unset BW_CLIENTID
unset BW_CLIENTSECRET
