#!/bin/bash



## shutdown menu Void linux



MENU=`echo -e "Logout\nReboot\nShutdown" | dmenu -h 18 -nb "#3c3836" -nf "#fbf1c7" -sb "#bdae93" -sf "#1d2021" -fn "Source Code Pro-8"`

            case "$MENU" in


                *Logout) bspc wm -r ;;

                *Reboot) sudo shutdown -r now ;;

                *Shutdown) sudo shutdown -P now ;;

            esac
