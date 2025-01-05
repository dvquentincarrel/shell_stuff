#!/bin/bash
filename=$(cat -)
nb_files=$(wc -l <(echo "$filename") | cut -f 1 -d' ')

if ! [[ -d /tmp/sxiv-del ]]; then
    mkdir -p /tmp/sxiv-del
fi
case "$1" in
    "C-c")
        printf '%s' "$filename" |
        perl -pe $'s/([ &!$\\\'"])''/\\\1/g;' -e 's/\n/ /g' |
        xclip -sel clip; notify-send -t 750 "Added to $nb_files files to clipboard";;
    "d")
        dragon $filename;;
    "Delete")
        zenity --question \
            --width=1000 \
            --text "Do you really want to delete $filename ?" &&
            (
                output=$(mv $filename /tmp/sxiv-del 2>&1 1>/dev/null) &&
                notify-send --category="transfer" $'binned files:\n'"$filename" ||
                notify-send --category="transfer.error" $'Could not delete files:\n'"$output" 
            );;
    "question")
        st -c FLOATING -e sh -c $'less -R <<EOF
\x1b[1mSxiv key-handlers - Applies to current / marked file(s)\x1b[m

\x1b[32;1m^C\x1b[m      Sends file to clipboard (relative path)
\x1b[32;1mDelete\x1b[m  Removes file
\x1b[32;1md\x1b[m       Open file in dragon
EOF';;
esac
