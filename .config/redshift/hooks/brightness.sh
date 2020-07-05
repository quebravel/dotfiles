#!/bin/sh

# Set brightness via xbrightness when redshift status changes

# Set brightness values for each status.
# Range from 1 to 100 is valid
brightness_day="90"
brightness_transition="50"
brightness_night="30"
# Set fade time for changes to one minute
fade_time=500
# Saida
output_video=DisplayPort-1

case $1 in
	period-changed)
		case $3 in
			night)
                xrandr --output $output_video --brightness 0.8 --gamma 1:1:1
				# xbacklight -set $brightness_night -time $fade_time
				;;
			transition)
                xrandr --output $output_video --brightness 0.9 --gamma 1:1:1
				# xbacklight -set $brightness_transition -time $fade_time
				;;
			daytime)
                xrandr --output $output_video --brightness 1.0 --gamma 1:1:1
				# xbacklight -set $brightness_day -time $fade_time
				;;
		esac
		;;
e
