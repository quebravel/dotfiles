#!/bin/bash
(transmission-remote -a $QUTE_URL &&
qutebrowser http://localhost:9091/transmission/web/) || exit 0

