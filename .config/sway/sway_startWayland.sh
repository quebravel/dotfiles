#!/usr/local/bin/bash

export XDG_RUNTIME_DIR=“/tmp/swaywm”
mkdir -p $XDG_RUNTIME_DIR
chmod 0700 $XDG_RUNTIME_DIR

export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=altgr-intl
export XKB_DEFAULT_OPTIONS=compose:menu,level3:ralt_switch
sway
