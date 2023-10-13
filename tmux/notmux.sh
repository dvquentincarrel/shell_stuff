#!/bin/bash
# Disables automatic connexion to tmux session. Either for a certain time, or as a toggle

if [ "$1" = "-h" ]; then
    echo "Enables/Disables automatic connexion to the main tmux session"
    echo "If a number is provided as an arg, reverses the value after that many seconds"
    exit 0
fi
if [ -f /tmp/notmux ];then
	rm /tmp/notmux
	msg="✅ tmux enabled"
else
	touch /tmp/notmux
	msg="❌ tmux disabled"
fi
if tty >/dev/null; then
	echo "$msg"
else
	notify-send -t 1000 "$msg"
fi
if [ -n "$1" ]; then
    sleep $1; notmux
fi
