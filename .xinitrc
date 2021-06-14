userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

[ -f ~/.Xdefaults ] && xrdb -merge ~/.Xdefaults

xsetroot -cursor_name left_ptr &

# feh --bg-scale ~/Imagens/wallpaper.png
$HOME/.fehbg
# $HOME/trigger_custom_refresh.sh &
# wal -R

# export MPD_HOST=$HOME/.config/mpd/socket
# mpd --kill; mpd &
# dunst &
# unclutter --timeout 7 &

if [ "$(command -v xset)" >/dev/null 2>&1 ];
then
    #xset s off      	        #Disable screen saver blanking
    #xset s 3600 3600 	        #Change blank time to 1 hour
    #xset -dpms 	            #Turn off DPMS
    xset s off -dpms 	        #Disable DPMS and prevent screen from blanking
    #xset dpms force off 	    #Turn off screen immediately
    #xset dpms force standby 	#Standby screen
    #xset dpms force suspend 	#Suspend screen
fi

# numlockx &

pulseaudio --start &

sxhkd &
exec dbus-launch --exit-with-session bspwm

# vim:ft=sh
