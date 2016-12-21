#!/bin/bash -eu

# This script launches a (firejail-ed) Xephyr instance,
# an inner WM inside it (xfwm4 to be exact, 
# because I use xfce, but that can be overridden),
# and then lets you launch your specific app inside this container.
#
# Note that the app inside the container should take care for its isolation by itself.
# For example, a GUI terminal app will not have access to parent's X11,
# but it will have access to everything else.

{ # read the whole file before executing it
set -o pipefail

if [ ! -v disp ]; then
	disp="$(date +%s)"
	disp="$((disp % 2000111000))" # stay inside X11 numbers limit
fi
export disp

xephyrArgs="${xephyrArgs:- -resizeable -screen 1024x768}"
firejail --noprofile \
	--caps.drop=all \
	--name="xephyr$disp" \
	--net=none \
	--nogroups \
	--nonewprivs \
	--noroot \
	--nosound \
	--private \
	--private-dev \
	--protocol=unix \
	--seccomp \
	--whitelist=/tmp/.X11-unix \
	-- Xephyr ${xephyrArgs} -no-host-grab :"$disp" -title "xephyr disp=$disp $*" 1>/dev/null &

xephyr_pid="$!"
export xephyr_pid

#### copy-paste templates:
# DISPLAY=":`ls -t /tmp/.X11-unix/ | head -1 | cut -c2-`"
# disp="${DISPLAY#:}"
# disp="${disp%.0}"
# echo "$disp"

# wait for Xephyr to launch...
inotifywait -qq --timeout 9 /tmp/.X11-unix/ # 1> /dev/null 2> /dev/null
>&2 echo "Xephyr started, display: $disp"

DISPLAY=":$disp"
export DISPLAY

wm_command="${wm_command:-xfwm4 --daemon}"
#wm_command="${wm_command:- wtftw}"
#setxkbmap -print | xkbcomp - :$disp

firejail --noprofile \
	--caps.drop=all \
	--name="wtftw$disp" \
	--net=none \
	--nogroups \
	--nonewprivs \
	--noroot \
	--nosound \
	--private \
	--private-dev \
	--protocol=unix \
	--seccomp \
	--whitelist=/tmp/.X11-unix/X"$disp" \
	-- $wm_command 1>/dev/null 2>/dev/null &


# vn971-specific. 
# Note that layout switching will be broken inside Xephyr.
# you can use an alternative switching method inside Xephyr as I currently do.
#
# It'd be great if Xephyr could just forward keyboard layout inside its X11,
# but it does not have such functionality.
# TODO: write a daemon-like thing to watch Xephyr and change guest layout whenever parent's changes?
(sleep 1; setxkbmap us,ru colemak, -option grp:ctrl_shift_toggle grp:caps_toggle) 1>/dev/null &
#(sleep 1; setxkbmap us,ru colemak, -option grp:ctrl_shift_toggle) &
#(sleep 1; setxkbmap us,ru colemak, -option caps:none grp:ctrl_shift_toggle) &
#(sleep 1; setxkbmap us,ru colemak, ) &

}