#!/bin/bash

# sort all files in working directory numerically
#
# arguments: -p Afsnit -z 2
#
# output example:
#   Afsnit 01.avi Afsnit 02.avi Afsnit 03.avi
#   ...
#   Afsnit 22.avi ... Afsnit 88.avi

iter=1
prefix="Afsnit"
padding="2"
IFS=$'\n'

usage() {
cat << EOF
usage: $0 options

This script sorts files numerically

OPTIONS:
    -p   Prefix of the filename
    -z   Zero-padding of the item number
EOF
}

while getopts "hp:z:" OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        p)
            prefix=$OPTARG
            ;;
        z)
            padding=$OPTARG
            ;;
        ?)
            usage
            exit 1
            ;;
    esac
done

for f in $( find . -maxdepth 1 -type f | sort -n )
do
    extension=`echo ${f#./*.}`
    num=`printf "%0${padding}d" $iter`
    mv $f "$prefix $num.$extension"
    iter=$(($iter+1))
done
