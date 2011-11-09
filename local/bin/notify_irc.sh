#!/bin/bash

~/.local/bin/kill_notify_irc.sh

(ssh scootserv -p 443 -o ServerAliveInterval=31536000 PermitLocalCommand=no ": > .irssi/fnotify ; tail -f .irssi/fnotify " | while read heading placebo message; do
    if [ `uname` == 'Linux' ]; then
        notify-send --hint=int:transient:1 "${heading}" "${message}"
    #else
        #growlnotify -t "${heading}" -m "${message}";
    fi
done)&
