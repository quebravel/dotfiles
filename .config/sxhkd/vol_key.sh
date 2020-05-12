#!/bin/bash

sink_atual=`pacmd list-sinks | grep "\* index:" | sed 's/[[:space:]][[:space:]]\* index:[[:space:]]//g'`

maisVolume(){
pactl set-sink-volume $sink_atual +5%
}

menusVolume(){
pactl set-sink-volume $sink_atual -5%
}

muteVolume(){
pactl set-sink-mute $sink_atual toggle
}

opcao=$1
escolha(){
echo $opcao
case $opcao in
   "-i") maisVolume ;;
   "-d") menusVolume ;;
   "-m") muteVolume ;;
esac
}

escolha
