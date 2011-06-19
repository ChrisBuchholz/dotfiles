#!/bin/bash

# sort X-Files-Season#-HQ-DVDRIP-###x###

iter=1
IFS=$'\n'
prefix='Afsnit'

for f in $( find . -maxdepth 1 -type d -not \( -name "." \) | sort -n )
do
    cd "$f"
    echo "$f"
    for ff in $( find . -maxdepth 1 -type d -not \( -name "." \) | sort -n )
    do
        cd "$ff"
        echo "$ff"
        title=`ls *.avi | sed 's/.*\-[ ]\(.*\)[ ]\(.*\)/\1/'` 
        mv *.avi "../../$prefix $iter - $title.avi"
        echo "$prefix $iter - $title.avi"
        mv *.En.srt "../../$prefix $iter - $title.srt"
        echo "$prefix $iter - $title.srt"
        iter=$(( iter + 1 ))
        cd ../
        echo "../"
        rm -rv "$ff"
    done
    cd ../
    echo "../"
    rm -rv "$f"
done
