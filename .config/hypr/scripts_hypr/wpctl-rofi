#!/bin/env bash

# dispositovo_opcoes=$(wpctl status | grep -m1 -A 5 "Sinks:" | head -n 10 | tr -d '│'" " | cut -d"*" -f2 | sed -n '/^[[:digit:]]/p' | cut -d\[ -f1 | rofi -dmenu)
dispositovo_opcoes=$(wpctl status | grep -m1 -A 3 Sinks | awk -F│ '{print $2}' | awk -F'.' '{print $0 $1 $2}' | awk -F\[ '{print $1}' | sed 's/  //g' | sed 's/* //g' | sed -n '/^[[:digit:]]/p' | rofi -dmenu -p "Pipewire:")
echo $dispositovo_opcoes

dispositivo_numero=$(echo $dispositovo_opcoes | cut -d. -f1)

# echo $dispositivo_numero

wpctl set-default $dispositivo_numero &> /dev/null

