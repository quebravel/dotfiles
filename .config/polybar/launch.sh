#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1
polybar bspoly &

# echo "Barra lançada..."
notify-send --urgency=low "Polybar lançado"
