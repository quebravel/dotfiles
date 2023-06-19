#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar-msg cmd quit

# Launch bar1
polybar bspoly 2>&1 | tee -a /tmp/polybar1.log & disown

# echo "Barra lançada..."
# notify-send --urgency=low "Polybar lançado"
