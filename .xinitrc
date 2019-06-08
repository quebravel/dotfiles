xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr &
feh --bg-scale ~/Imagens/wallpaper.png

if [ -e /tmp/mplayer-control ] ; then
    echo 'ok fifo for mplayer'
else
    mkfifo /tmp/mplayer-control
fi

sh ~/.mkmplayer.sh
numlockx &

sxhkd &
exec bspwm
