#!/bin/bash
interfaces=( $(netstat -in | egrep 'utun\d .*\d+\.\d+\.\d+\.\d+' | cut -d ' ' -f 1) )
rulefile="rules.tmp"
echo "" > $rulefile
sudo pfctl -a com.apple/tun -F nat
for i in "${interfaces[@]}"
do
  RULE="nat on ${i} proto {tcp, udp, icmp} from 192.168.64.0/24 to any -> ${i}"
  echo $RULE >> $rulefile
done
sudo pfctl -a com.apple/tun -f $rulefile
rm $rulefile
