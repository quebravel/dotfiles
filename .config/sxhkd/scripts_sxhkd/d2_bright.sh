#!/bin/env bash

monitor=`xrandr | grep -w connected | cut -f '1' -d ' '`

nothing=`xrandr --verbose | grep Brightness: | cut -f '1,2' -d '.' | awk '{print $2}'`
# nothing=`xrandr --verbose | grep Brightness: | tr -cd '0-9 '`

# light=`echo -e "1.0\0.90\n0.85\n0.75\n0.65\n0.55\n0.45\n0.35\n0.20\n0.10\n0.05" | dmenu -y 15 -h 18 -nb "#3c3836" -nf "#fbf1c7" -sb "#bdae93" -sf "#1d2021" -fn "JetBrainsMono Nerd Font-8" -p "Selecionar brilho da tela"`
# 
# 
# if [ -z $light ]; then
#     xrandr --output $monitor --brightness $nothing
# else
#     xrandr --output $monitor --brightness $light
# fi
# 

incrementa(){
    vbrlh=`echo $nothing + .10 | bc`
    # echo 0$vbrlh
    # echo $vbrlh
    # echo $nothing
    if [[ $vbrlh == 1.10 ]]; then
        exit 0
    else
        xrandr --output $monitor --brightness 0$vbrlh
    fi
}

decrementa(){
    vbrlh=`echo $nothing - .10 | bc`
    # echo $vbrlh
    # echo $nothing
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


