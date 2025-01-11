if which tmux &>/dev/null && [ -z "$TMUX" ] && [ -z "$NOMUXER" ] && pgrep Xorg; then
    # If enabled, joins the tmux session 'mgp' or creates it if it doesn't exist
    [ -f '/tmp/notmux' ] && return 0;
    if tmux ls; then
        exec tmux new-session -t mgp
    else
        tmux new-session -d -s main -t mgp
        exec tmux new-session -t mgp
    fi
fi
