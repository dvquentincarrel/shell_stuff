#!/bin/env bash
if [[ $1 = global ]]; then
    sink=@DEFAULT_AUDIO_SINK@
fi

wpctl set-volume $sink "$2"
vol=$(wpctl get-volume $sink)
if tty &>/dev/null; then
    notify-send $(tty)
    echo "$vol"
else
    notify-send "$vol" awdawd
fi
