#!/bin/env bash

if command -v wpctl &>/dev/null; then
    sink=@DEFAULT_AUDIO_SINK@
    awk '
    /MUTED/ {
        printf "🔊 MUTE\n", $2
        printf "MUTE\n", $2
        printf "#FF0000\n"
    }
    ! /MUTED/ {
        printf "🔊 %s%%\n", $2
        printf "%s%%\n", $2
    }
    '< <(wpctl get-volume $sink)
else # pactl
    sink=@DEFAULT_SINK@
    if pactl get-sink-mute $sink | grep -q yes; then
        echo "🔊 MUTE"
        echo "MUTE"
        echo "#FF0000"
    else
        awk -F / '
        NR==1 {
            gsub(" ", "", $0)
            printf "🔊 %s/%s\n", $2, $4
            printf "%s/%s\n", $2, $4
        }
        ' < <(pactl get-sink-volume $sink)
    fi
fi
