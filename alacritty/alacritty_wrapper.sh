alacritty msg create-window "$@" 2>/dev/null || \
    TMUX='' ZELLIJ='' alacritty --hold --class HIDEME,HIDEME -e alacritty msg create-window "$@"&
