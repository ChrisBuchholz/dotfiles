#!/bin/bash

# irssi notifications

pkill -f '.*ssh cb@178.79.133.30 -p 443 -o ServerAliveInterval=31536000'

(ssh cb@178.79.133.30 -p 443 -o ServerAliveInterval=31536000 PermitLocalCommand=no ": > .irssi/fnotify ; tail -f .irssi/fnotify " | while read heading placebo message; do
    if [ `uname` == 'Darwin' ]; then
        growlnotify -t "${heading}" -m "${message}";
    else
        notify-send "${heading}" "${message}"
    fi
done)&
