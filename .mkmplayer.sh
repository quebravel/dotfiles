#!/bin/env bash

if [ -e /tmp/mplayer-control ] ; then
    echo 'Eba! posso controlar mplayer'
    exit 0
else
    mkfifo /tmp/mplayer-control
    exit 0
fi
