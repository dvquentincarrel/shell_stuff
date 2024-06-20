if which zellij &>/dev/null && [ -z "$ZELLIJ" ] && [ -z "$NOMUXER" ]; then
    # If enabled, joins the zellij session 'main' or creates it if it doesn't exist
    [ -f '/tmp/nozellij' ] && return 0;
    if zellij ls | grep main; then
        exec zellij attach main
    else
        exec zellij -s main
    fi
fi
