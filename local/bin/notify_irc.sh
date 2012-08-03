#!/bin/bash

~/.local/bin/kill_notify_irc.sh

(ssh scootserv -p 443 -o ServerAliveInterval=31536000 PermitLocalCommand=no ": > .irssi/fnotify ; tail -f .irssi/fnotify " | while read heading placebo message; do
    if [ `uname` == 'Linux' ]; then
        notify-send --hint=int:transient:1 "${heading}" "${message}"
    elif [ `uname` == 'Darwin' ]; then
        /Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier IRC "${heading}" "${message}" com.googlecode.iterm2 > /dev/null 2>&1
    fi
done)&
