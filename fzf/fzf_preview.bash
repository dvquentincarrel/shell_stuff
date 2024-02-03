#!/bin/bash
if [[ -f "$1" ]]; then
    batex=$(which bat batcat 2>/dev/null | head -n 1)
    if [[ -n "$batex" ]]; then
        $batex -p -r :50 --color=always "$1"
    else
        head -n 50 "$1"
    fi
elif [[ -d "$1" ]]; then
    tree -C "$1"
else
    echo "$1"
fi
