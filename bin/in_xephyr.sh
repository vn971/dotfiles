#!/bin/bash -eu

# The script should be sourced, in order to import
# its `in_xephyr` bash function.
#
# You can use this bash function like so:
#   in_xephyr xterm
# and it will launch `xterm` inside a newly created X11 (Xephyr) instance.
#
# You can also create a multi-line bash function and execute it in Xephyr:
#   function my_func {
#     echo "hello there, my DISPLAY is $DISPLAY"
#     launch GUI program
#   }
#   in_xephyr my_func

{ # read the whole file before executing it
set -o pipefail

function in_xephyr() {
	source xepsource.sh
	# TODO: set +e; execute the command; capture exit code; set -e; print exit code
	"$@" || true;
	firejail --quiet --shutdown="wtftw$disp" || true
	firejail --quiet --shutdown="xephyr$disp" || true
}

# Obviosly it's not clean to launch a function by hard-coded name while source-ing... 
# But well, it's done anyway.
if type xephyr_me 1>/dev/null 2>/dev/null; then
	xephyr_window_name="$0"
	in_xephyr xephyr_me
fi

};ret="$?";return "$ret" 2>/dev/null || exit "$ret"