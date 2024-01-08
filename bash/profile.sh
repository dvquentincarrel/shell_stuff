export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export PATH=~/.local/bin:$PATH

id=$(uname -a)
if echo "$id" | grep -qi manjaro; then
    export WALLPAPERS="/mnt/storage/pictures/Wallpaper/"
    export QBL_ASYNC=false
    xrandr --output HDMI-0 --primary --left-of DP-1
elif echo "$id" | grep -qi ubuntu; then
    export PATH=/home/quentin/opi_repo2:$PATH
    xrandr --output eDP-1 --primary
    xrandr --output HDMI-1 --left-of eDP-1
    xrandr --auto
fi

export FOTM_TERM="alacritty"
export WINIT_X11_SCALE_FACTOR=1 # Fixes issue with the awful Zoom Linux version

xset r rate 250 50 # delay, rate
setxkbmap leyaourt || setxkbmap 'us(altrg-intl)' || setxkbmap us
