#!/bin/sh
# >>> isoloom-1.0 secret-from-file shim (auto-added by convert-lab.py) >>>
# Inputs now arrive as files (isoloom.yml `files:`), not environment variables.
# Read each into its old variable when unset, keeping the dev/CI fallback working.
for __p in CTF_FLAG_MAIN:/run/lab/ctf_flag_main; do
  __n=${__p%%:*}; __f=${__p#*:}
  eval "__v=\${$__n:-}"
  if [ -z "$__v" ] && [ -s "$__f" ]; then
    __v=$(tr -d '\r\n' < "$__f"); eval "export $__n=\"\$__v\""
  fi
done
unset __p __n __f __v 2>/dev/null || true
# <<< isoloom-1.0 secret-from-file shim <<<
# Places the player's flag (CTF_FLAG_MAIN, given by the launcher) where the challenge reads it
# (/chroot/flag, /chroot/home/user/flag.txt, /chroot/flag.txt, in the volume over that directory); without one (CI, a run by hand) the development flag.
dev='CTF{dev-google-ctf-2023-write-flag-where}'
v="${CTF_FLAG_MAIN:-$dev}"
printf '%s' "$v" > /chroot/flag
chmod 444 /chroot/flag
printf '%s' "$v" > /chroot/home/user/flag.txt
chmod 444 /chroot/home/user/flag.txt
printf '%s' "$v" > /chroot/flag.txt
chmod 444 /chroot/flag.txt
