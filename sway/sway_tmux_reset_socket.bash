#!/bin/env bash
path=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(\pgrep -x sway).sock
tmux set-environment -g SWAYSOCK "$path"
echo "Socket set to $path"
