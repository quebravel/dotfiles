#!/bin/bash

um=`dmenu -noinput -h 18 -nf "#fbf1c7" -nb "#3c3836" -sf "#1d2021" -sb "#bdae93" -fn "Source Code Pro-8:normal" -p "translate"`

palavra=`trans -no-ansi -no-bidi -no-warn -brief "$um" # | sed -n 3,4p`

if [ -z $um ]
then
    exit 1
else
    echo -e $palavra | dmenu -l 1 -h 18 -nf "#fbf1c7" -nb "#3c3836" -sf "#1d2021" -sb "#bdae93" -fn "Source Code Pro-8:normal"
fi

