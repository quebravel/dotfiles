#!/bin/bash

if [ "$(pgrep -x redshift)" ]; then
    pkill redshift & dunstify -u normal "Redshift" "Desativado"
else
    redshift -t 5100:3900 -l -1.396142:-48.386560 &
    dunstify -u normal "Redshift" "Ativo"
fi

