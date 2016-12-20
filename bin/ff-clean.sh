#!/bin/bash -eu
set -o pipefail

script_path="$(realpath -- "$0")"
trap 'chmod u+w "$script_path"' EXIT
chmod u-w "$script_path" || true


dir="$HOME/.jails/deleteme-firefox-$(date +%s)"
mkdir -p "$dir"

# --blacklist=/usr/lib/firefox/browser/defaults/preferences/syspref.js \

function launch_ff() {
	disp="${DISPLAY#:}"
	disp="${disp%.0}"
	firejail --private="$dir" --whitelist=/tmp/.X11-unix/X"$disp" --profile=~/.config/firejail/firefox.profile firefox -no-remote
}

if [[ -v noxephyr ]]; then
	launch_ff
else
	source in_xephyr.sh
	in_xephyr launch_ff
fi

rm -rf "$dir/.cache"
