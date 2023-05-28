#!/bin/bash

dispositovo_opcoes=$(wpctl status | grep -m1 -A 5 "Sinks:" | head -n 10 | tr -d '│'" " | cut -d"*" -f2 | sed -n '/^[[:digit:]]/p' | dmenu -y 0 -h 17 -nf "#f8f8f2" -nb "#44475a" -sf "#000" -sb "#bd93f9" -fn "JetBrainsMono Nerd Font-9:normal" -p "pipewire wpctl")

# echo $dispositovo_opcoes

dispositivo_numero=$(echo $dispositovo_opcoes | cut -d. -f1)

# echo $dispositivo_numero

wpctl set-default $dispositivo_numero &> /dev/null
