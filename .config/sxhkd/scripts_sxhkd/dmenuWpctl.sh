#!/bin/bash

dispositovo_opcoes=$(wpctl status | grep -A 4 "Sinks" | head -n 3 | tail -n 2 | tr -d '│'" " | cut -d"*" -f2 | dmenu)

# echo $dispositovo_opcoes

dispositivo_numero=$(echo $dispositovo_opcoes | cut -d. -f1)

echo $dispositivo_numero

wpctl set-default $dispositivo_numero
