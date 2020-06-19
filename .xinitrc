[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xsetroot -cursor_name left_ptr &

# feh --bg-scale ~/Imagens/wallpaper.png
$HOME/.fehbg
# $HOME/trigger_custom_refresh.sh &
# wal -R

# export MPD_HOST=$HOME/.config/mpd/socket
# mpd --kill; mpd &
# dunst &
# unclutter --timeout 7 &

# if [ -e /tmp/mplayer-control ] ; then
#     echo 'ok fifo for mplayer'
# else
#     mkfifo /tmp/mplayer-control
# fi

numlockx &

sxhkd &
exec bspwm

# vim:ft=sh
