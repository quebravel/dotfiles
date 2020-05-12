#!/bin/bash 

new_sink=$(pacmd list-sinks | grep index | tee /dev/stdout | grep -m1 -A1 "* index" | tail -1 | cut -c12-)

echo "Setting default sink to: $new_sink";
pacmd set-default-sink $new_sink
pacmd list-sink-inputs | grep index | while read line
do
echo "Moving input: ";
echo $line | cut -f2 -d' ';
echo "to sink: $new_sink";
pacmd move-sink-input `echo $line | cut -f2 -d' '` $new_sink

# notify-send -u normal -t 600 "Troca Audio" "SINK: $new_sink"

current=`pactl list short | grep RUNNING | cut -f 2`

notify-send -u normal -t 2200 "Troca Audio" "SINK: $current"

done
