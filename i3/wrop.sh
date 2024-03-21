#!/bin/bash
# Handles screenshotting with scort
location="$HOME/screenshots"
[ -d  "$location" ] || mkdir -p "$location"

if [ "$1" = "save" ]; then
	# Screenshots everything displayed
	scrot "$location/%Y-%m-%d_%H:%M:%S_scrot.png" -q 25
	notify-send --expire-time=1000 "screenshot" "Screenshot saved\n($location)"
elif [ "$1" = "select" ]; then
	# Puts the selected zone in the clipboard
	scrot -s -f -e 'xclip -selection clipboard -t image/png -f -i $f' "$location/%Y-%m-%d_%H:%M:%S_scrot.png" && \
	notify-send --expire-time=1000 "screenshot" "Zone selected\n(clipboard + $location)" || \
	notify-send --expire-time=1000 "screenshot" "Screenshot aborted"
elif [ "$1" = "window" ]; then
	# Puts a screenshot of the current window in the clipboard
	scrot -u -e 'xclip -selection clipboard -t image/png -f -i $f' "$location/%Y-%m-%d_%H:%M:%S_scrot.png" 
	notify-send --expire-time=1000 "screenshot" "Window saved\n(clipboard + $location)"
else
	echo "$1 argument not recognized. Valid arguments are: save, select, window"
	notify-send screenshot "invalid argument \"$1\" passed to the ptrscr utility. Valid arguments are: save, select, window"
fi
