#!/bin/sh
# The program greets with its rhyme and its memory mappings.
# The service runs the challenge in nsjail for each connection and greets the player first.
(sleep 4) | curl -sS --max-time 6 telnet://challenge:1337 2>/dev/null | grep -q "This challenge is not a classical pwn"
