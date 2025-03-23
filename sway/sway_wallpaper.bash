#!/bin/env bash
pkill sway_wallpaper
printf "%s" "${0##*/}" > /proc/$$/comm

if [[ -z $1 ]]; then
    msg="Usage: sway_wallpaper DELAY (0 for non fixed backgrounds)"
    if tty &>/dev/null; then
        echo "$msg"
    else
        notify-send "$msg"
    fi
    exit 1
fi

# Handle cleanup
trap 'pkill swaybg; exit' SIGINT

wallpaper_dir=${2:-${XDG_PICTURES_DIR:-$HOME/Pictures}/wallpapers}
outputs=($(swaymsg -t get_outputs | jq -r .[].name))
delay=$(bc -l <<< "$1 / ${#outputs[@]}")

function get_picture_list() {
    IFS= readarray -d '' files < <(find "$wallpaper_dir" -type f -print0 | shuf -z)
}

function set_bg() {
    for output in ${outputs[@]}; do
        pid=$(jobs -rp | head -n1)
        swaybg -o $output -i "${files[-1]}" -m fill &>/dev/null &
        if ! $SETUP; then
            sleep 0.5 # Prevents flickering, 0.5 should be enough time for the new wallpaper to be set
            kill $pid
            wait $pid
        fi
        unset files[-1]
        if [[ ${#files[@]} -eq 0 ]]; then
            get_picture_list
        fi
    done
}

pids=$(pgrep swaybg)
SETUP=true
get_picture_list
set_bg
kill $pids
SETUP=false

# Handle non-loop invokation
[[ $1 = 0 ]] && exit

while true; do
    sleep $delay
    set_bg
done
