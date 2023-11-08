typeset -U PATH path
# path=("$HOME/.local/bin" /other/things/in/path "$path[@]")
path=("$HOME/.local/bin" "$path[@]")
export PATH

if [ -e /home/user/.nix-profile/etc/profile.d/nix.sh ]; then . /home/user/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="$PATH:/home/user/.foundry/bin"
. "/home/user/.starkli/env"
