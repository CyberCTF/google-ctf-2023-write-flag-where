#!/bin/sh
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
