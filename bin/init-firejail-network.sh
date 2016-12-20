#!/bin/bash -eu
set -o pipefail

if nmcli | grep 'enp2s0f1.* connected to ' 2>/dev/null 1>/dev/null ; then
	echo "net enp2s0f1" > ~/.config/firejail/netNow
else
	echo "" > ~/.config/firejail/netNow
fi
