if ! pgrep alacritty; then
    export TMUX=
    export ZELLIJ=
    alacritty --hold --class HIDEME,HIDEME -e printf 'daemon window'&
fi
for ((i=0; i<2000; i++)); do
    if pgrep alacritty; then
        break
    fi
    sleep 0.05
done

alacritty msg create-window "$@"
