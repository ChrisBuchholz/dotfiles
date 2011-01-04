#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

tint2 &
exec ck-launch-session openbox-session
