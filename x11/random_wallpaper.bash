#!/bin/env bash
help_msg="random_wallpaper [FILE/DIR] [-d slideshow delay (seconds)]"

while getopts "d:hs" opt; do
    case $opt in
        h)  echo -e "$help_msg"; exit 0;;
        d)  DURATION=$OPTARG;;
        *)  echo "invalid option '$opt'"
            exit 1;;
        esac
    done
    shift $((OPTIND -1))

if [[ -z $WALLPAPER_SETTER ]]; then
    printf 'The variable \x1b[33m$WALLPAPER_SETTER\x1b[m needs to be set\n'
    exit 1
fi

if [[ $# -lt 1 ]]; then
    WALLPAPER_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/wallpapers"
elif [[ -d $1 ]]; then
    WALLPAPER_DIR="$1"
fi

if [[ -n $WALLPAPER_DIR ]]; then
    readarray -t WALLPAPERS < <(find -L $WALLPAPER_DIR -type f | grep -E '\.(jxl|jpg|jpeg|png|webp)')
else
    WALLPAPERS=("$1")
fi

outputs=($(xrandr | grep '\sconnected' | cut -f1 -d ' '))

nb_entries=${#WALLPAPERS[@]}
# Gets a random index between 0 and number of entries
while true; do
    index=($(shuf -i 0-$nb_entries -n ${#outputs[@]}))
    if [[ $WALLPAPER_SETTER =~ xwallpaper ]]; then
        data=()
        for ((i=0; i < ${#outputs[@]}; i++)); do
            data+=(--output ${outputs[$i]} --zoom "${WALLPAPERS[${index[$i]}]}")
        done
        xwallpaper "${data[@]}"
    else
        $WALLPAPER_SETTER "${WALLPAPERS[${index[0]}]}"
    fi
    if [ -z $DURATION ]; then
        echo $DURATION
        break
    fi
    sleep $DURATION
done
