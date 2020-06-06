#!/bin/bash

um=`echo -e "" | dmenu -noinput -h 45 -y 20 -nb "#0087ff" -nf "#ffffff" -sb "#d5c4a1" -sf "#000000" -fn "monaco-10" -p "Traduzir"`

palavra=`trans -no-ansi -no-bidi -no-warn "$um" | sed -n 3,4p`

if [ -z $um ]
then
    exit 1
else
    dunstify -u normal -t 12000 "Tradução" "$palavra"
fi

