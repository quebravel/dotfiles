#!/bin/bash



## shutdown menu Void linux



MENU=`echo -e "                Shutdown                \n                Reboot                \n                Logout                " | dmenu -h 19 -nb "#fe8019" -nf "#282828" -sb "#282828" -sf "#fbf1c7" -fn "JetBrainsMono Nerd Font-9"`

            case "$MENU" in

                *Shutdown) shutdown -P now ;;

                *Reboot) shutdown -r now ;;

                *Logout) bspc wm -r ;;

            esac
