#!/bin/bash
# set wallpaper with feh
eval `cat ~/.fehbg` &
# cursor
xsetroot -cursor_name left_ptr
# keyboard layout
setxkbmap -layout dk
# disable touchpad clicks while typing
syndaemon -k -t -d -i 1 > /dev/null &
# hide mouse after some idle time
unclutter -idle 5 &
# start xscreensaver
/usr/bin/xscreensaver -no-splash &
# start WM
exec ck-launch-session xmonad
