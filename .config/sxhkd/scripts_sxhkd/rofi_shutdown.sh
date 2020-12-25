#!/bin/bash



## shutdown menu Void linux



MENU="$(rofi -config ~/.config/rofi/shutdown.ribbon.rasi -sep "|" -dmenu -i -p 'System' <<< "Logout|Reboot|Shutdown")"

            case "$MENU" in


                *Logout) bspc wm -r ;;

                *Reboot) sudo shutdown -r now ;;

                *Shutdown) sudo shutdown -P now ;;

            esac
