#!/bin/env bash

monitor=`xrandr | grep -w connected | cut -f '1' -d ' '`

light=`echo -e "90\n85\n75\n65\n55\n45\n35\n20\n10\n05" | dmenu -h 18 -nb "#3c3836" -nf "#fbf1c7" -sb "#bdae93" -sf "#1d2021" -fn "Source Code Pro-8" -p "Selecionar brilho da tela"`

xrandr --output $monitor --brightness 0.$light
