#! /bin/sh

chosen=$(printf "  Desligar\n  Reiniciar\n  Log Out" | wofi -dmenu -i -c ~/.config/wofi/config.power)

case "$chosen" in
	"  Desligar") poweroff ;;
	"  Reiniciar") reboot ;;
	"  Log Out") hyrpctl exit ;;
	*) exit 1 ;;
esac

	# "  Suspend") systemctl suspend-then-hibernate ;;
	# "  Hibernate") systemctl hibernate ;;
	# "  Lock") betterlockscreen -l ;;
