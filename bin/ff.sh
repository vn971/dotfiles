#!/bin/bash -eu
{ # read the whole file before executing it
set -o pipefail

if [ "$#" -gt 1 ]; then
	>&2 echo "ERROR."
	>&2 echo "Need zero arguments (to create a temp firefox instance)"
	>&2 echo "or one argument (to create a named firefox instance)."
elif [ "$#" -eq 1 ]; then
	dir="$HOME/.jails/firefox-$1"
else
	dir="$HOME/.jails/deleteme-firefox-$(date +%s)"
fi

if [ ! -d "$dir" ]; then
	cp -a "$HOME"/.jails/deleteme-firefox-template "$dir"
fi


function launch_ff() {
	disp="${DISPLAY#:}"
	disp="${disp%.0}"
	firejail --private="$dir" --whitelist=/tmp/.X11-unix/X"$disp" --blacklist="$dir"/.noxephyr --profile=~/.config/firejail/firefox.profile firefox -no-remote
}

if [[ -v noxephyr || -f "$dir"/.noxephyr ]]; then
	launch_ff
else
	xephyr_window_name="ff.sh $*"
	source in_xephyr.sh
	in_xephyr launch_ff
fi

if [[ ! -v profile ]]; then
	rm -rf "$dir/.cache"
fi

};ret="$?";return "$ret" 2>/dev/null || exit "$ret"