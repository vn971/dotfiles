#!/bin/bash -eu

# The intention of the script is to source it,
# in order to make `in_xephyr` bash function available in an external program.
#
# You can use this bash function like so:
#   in_xephyr xterm
# and it will launch `xterm` inside a newly created X11 (Xephyr) instance.
#
# You can also create a multi-line bash function to be executed inside the Xephyr instance,
# and executi via:
#   in_xephyr my_bash_func

function in_xephyr() {
	source xepsource.sh
	# TODO: set +e; execute the command; capture exit code; set -e; print exit code
	"$@" || true;
	( firejail --quiet --shutdown="wtftw$disp"; firejail --quiet --shutdown="xephyr$disp"; ) &
}

# Obviosly it's not clean to launch a function by hard-coded name while source-ing... 
# But well, it's done anyway.
if type xephyr_me 1>/dev/null 2>/dev/null; then
	in_xephyr xephyr_me
fi
