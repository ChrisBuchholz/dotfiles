#!/bin/bash

~/.local/bin/kill_notify_irc.sh

(ssh cb@178.79.133.30 -p 443 -o ServerAliveInterval=31536000 PermitLocalCommand=no ": > .irssi/fnotify ; tail -f .irssi/fnotify " | while read heading placebo message; do
    if [ `uname` == 'Darwin' ]; then
        growlnotify -t "${heading}" -m "${message}";
    else
        notify-send --hint=int:transient:1 "${heading}" "${message}"
    fi
done)&
