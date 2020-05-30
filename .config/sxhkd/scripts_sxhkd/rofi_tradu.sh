#!/bin/bash

um=`echo -e "traduzir" | rofi -dmenu`

palavra=`trans -no-ansi -no-bidi -no-warn "$um" | sed -n 3,4p`

if [ -z $um ]
then
    exit 1
else
    dunstify -u normal -t 6000 "Tradução" "$palavra"
fi

