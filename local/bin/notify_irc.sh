#!/bin/bash

~/.local/bin/kill_notify_irc.sh

if [ `uname` == 'Linux' ]; then
    (ssh scootserv -p 443 -o ServerAliveInterval=31536000 PermitLocalCommand=no ": > .irssi/fnotify ; tail -f .irssi/fnotify " | while read heading placebo message; do
        notify-send --hint=int:transient:1 "${heading}" "${message}"
    done)&
fi
