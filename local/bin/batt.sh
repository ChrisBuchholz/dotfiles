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
        if [ $perc -lt 100 ]; then
            echo $HEART_EMPTY
        else
            echo $HEART_FULL
        fi
        perc=$(($perc - $inc))
    done
}

BATTERY_STATUS=`pmset -g batt`
BATTERY_STATUS=${BATTERY_STATUS:59:3}

if [ $BATTERY_STATUS == 'cha' ]; then
    BATTERY_STATUS=`pmset -g batt`
    BATTERY_STATUS=${BATTERY_STATUS:54:3}
fi

BATTERY_STATUS=$(echo $BATTERY_STATUS | sed -e 's/%//g')

echo `cutinate $BATTERY_STATUS` 
