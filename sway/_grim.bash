#!/bin/env bash
# Wrapper for grim & slurp
OUTPUT_FILE=~/screenshots/$(date +%F_%T_grim.png)
args=()
done=false
OPTIONS=(select all sel_window cur_window col_picker)
HELP_MSG='Usage: _grim [-h|--help] [-o|--options] (all | select | sel_window | cur_window | col_picker)'

function processing() {
    $done || return 1
    grim "${args[@]}" "$OUTPUT_FILE"
    wl-copy -t image/png < "$OUTPUT_FILE"
}

function post() {
    if $done; then
        notify-send -t 1500 "Screenshot taken & added to clipboard"
    else
        notify-send -t 1500 "Screenshot aborted"
    fi
}

if [[ $1 = -h ]] || [[ $1 = --help ]]; then
    echo "$HELP_MSG"
    exit 0
elif [[ $1 = -o ]] || [[ $1 = --options ]]; then
    printf "%s\n" "${OPTIONS[@]}"
    exit 0
# Captures everything
elif [[ $1 = all ]]; then
    done=true
# Select a region
elif [[ $1 = select ]]; then
    if coords=$(slurp); then
        args+=("-g" "$coords")
        done=true
    fi
# Select a window
elif [[ $1 = sel_window ]]; then
    # Extract window coordinates from swaymsg
    coords=$(
        swaymsg -t get_tree |
            jq -r '.. | select(.pid? and .visible?) | "\(.rect.x+.window_rect.x),\(.rect.y+.window_rect.y) \(.window_rect.width)x\(.window_rect.height)"' |
            slurp -r
    )
    if [[ -n $coords ]]; then
        args+=("-g" "$coords")
        done=true
    fi
# Select current window
elif [[ $1 = cur_window ]]; then
    args+=("-g" "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible? and .focused?) | "\(.rect.x+.window_rect.x),\(.rect.y+.window_rect.y) \(.window_rect.width)x\(.window_rect.height)"')")
# Color picker
elif [[ $1 = col_picker ]]; then
    if coords=$(slurp -p -b FFFFFF00); then 
        function processing() {
            grim -g "$coords" "$XDG_RUNTIME_DIR"/grim_color_picker.png
            magick "$XDG_RUNTIME_DIR"/grim_color_picker.png -format '#%[hex:u]' info: | wl-copy
        }
        function post {
            notify-send -i "$XDG_RUNTIME_DIR"/grim_color_picker.png "$(wl-paste) put in clipboard"
        }
    fi
else
    echo "$HELP_MSG"
    exit 1
fi

processing
post
