if ! pgrep alacritty; then
    export TMUX=
    export ZELLIJ=
    alacritty --hold --class HIDEME,HIDEME -e printf 'daemon window'&
fi

i=0
# Posix sh loop
while [ $i -lt 2000 ]; do
    alacritty msg create-window "$@"
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 0.05
    i=$((i + 1))
done


