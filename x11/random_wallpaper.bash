#!/bin/env bash
help_msg="random_wallpaper [FILE/DIR] [-d slideshow delay (seconds)]"

while getopts "d:h" opt; do
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

nb_entries=${#WALLPAPERS[@]}
printf '%s\n' "${WALLPAPERS[@]}"
# Gets a random index between 0 and number of entries
while true; do
    index=$(shuf -i 0-$nb_entries -n 1)
    $WALLPAPER_SETTER "${WALLPAPERS[$index]}"
    if [ -z $DURATION ]; then
        echo $DURATION
        break
    fi
    sleep $DURATION
done
