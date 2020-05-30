#!/bin/env bash

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

dmenu_run -h 17 -y 22 -nb "$color0" -nf "$color4" -sb "$color4" -sf "$color0" -fn "ohsnap" -p "dmenu2"
