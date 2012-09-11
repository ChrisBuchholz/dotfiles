#!/bin/bash
if [ `uname` == 'Linux' ]; then
    energy_now=`cat /sys/class/power_supply/BAT0/energy_now`
    energy_full=`cat /sys/class/power_supply/BAT0/energy_full`
    echo $((100 * $energy_now / $energy_full))"%"
elif [ `uname` == 'Darwin' ]; then
    str=`pmset -g batt`
    str=${str:59:3}
    if [ $str == "cha" ]; then
        echo " AC"
    else
        echo $str
    fi
fi
