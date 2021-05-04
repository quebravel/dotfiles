current=$(grep default /dev/sndstat | cut -c4-4);

if [ $current == 2 ]; then
    sysctl hw.snd.default_unit=3;
elif [ $current == 0 ]; then
    sysctl hw.snd.default_unit=1;
elif [ $current == 1 ]; then
    sysctl hw.snd.default_unit=2;
elif [ $current == 3 ]; then
    sysctl hw.snd.default_unit=0;
else
    sysctl hw.snd.default_unit=1;
fi

#restart mixer on the panel so it reads the new device:
kill `ps -aux | grep -i mixer | awk '{print $2}'`

#notify after the switch happened:
verbose=$(grep default /dev/sndstat)
notify-send "Activate: $verbose" --icon=dialog-information;
