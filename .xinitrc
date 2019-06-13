[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xsetroot -cursor_name left_ptr &
#feh --bg-scale ~/Imagens/wallpaper.png
$HOME/.fehbg

if [ -e /tmp/mplayer-control ] ; then
    echo 'ok fifo for mplayer'
else
    mkfifo /tmp/mplayer-control
fi

numlockx &

sxhkd &
exec bspwm
