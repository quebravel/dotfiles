#!/bin/bash

awk '/^[a-z]/ && last {print "",$0,"\t",last,""} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |
    column -t -s $'\t' |
    # rofi -no-config -dmenu -i -markup-rows -no-show-icons -width 1000 -lines 15 -yoffset 40 
    dmenu -l 100 -h 18 -nf "#fbf1c7" -nb "#3c3836" -sf "#1d2021" -sb "#bdae93" -fn "JetBrainsMono Nerd Font-8:normal" -p "Keybindings sxhkd"
