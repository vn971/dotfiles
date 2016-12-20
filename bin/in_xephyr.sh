#!/bin/bash -eu

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
