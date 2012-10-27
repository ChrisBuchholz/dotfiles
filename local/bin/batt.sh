#!/bin/bash

## inspired by https://raw.github.com/richoH/dotfiles/master/bin/battery

HEART_FULL=♥
HEART_EMPTY=♡
NUM_HEARTS=5

cutinate()
{
    perc=$(($1 + 99))
    inc=$(( 100 / $NUM_HEARTS))

    for i in `seq $NUM_HEARTS`; do
        if [ $perc -lt 100 ] || [ $1 -lt 11 ]; then
            echo $HEART_EMPTY
        else
            echo $HEART_FULL
        fi
        perc=$(($perc - $inc))
    done
}

BATTERY_STATUS=`pmset -g batt | egrep -o '[0-9]+%' | sed -e 's/%//g'`

echo `cutinate $BATTERY_STATUS` 
