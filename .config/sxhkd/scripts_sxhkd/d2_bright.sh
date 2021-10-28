#!/bin/env bash

monitor=`xrandr | grep -w connected | cut -f '1' -d ' '`

nothing=`xrandr --verbose | grep Brightness: | awk '{print $2}'`

incrementa(){
    vbrlh=`echo $nothing + .10 | bc`
    if [[ $vbrlh == 1.10 ]]; then
        exit 0
    else
        xrandr --output $monitor --brightness 0$vbrlh
    fi
}

decrementa(){
    vbrlh=`echo $nothing - .10 | bc`
    if [[ $vbrlh == .10 ]]; then
        exit 0
    else
        xrandr --output $monitor --brightness 0$vbrlh
    fi
}

while getopts "idh" o; do
    case "${o}" in
        i) incrementa
            ;;
        d) decrementa
            ;;
    esac
done

