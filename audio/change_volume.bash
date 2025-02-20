#!/bin/env bash
if command -v wpctl &>/dev/null; then
    if [[ $1 = global ]]; then
        sink=@DEFAULT_AUDIO_SINK@
    fi

    wpctl set-volume $sink "$2"
    wpctl get-volume $sink
else # pa-cli
    if [[ $1 = global ]]; then
        sink=@DEFAULT_SINK@
    fi
    vol=$(sed 's/\([0-9]\+%\)\(.\)/\2\1/'<<< "$2")
    pactl set-sink-volume $sink "$vol"
    pactl get-sink-volume $sink
fi
