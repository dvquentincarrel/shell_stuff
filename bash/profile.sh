export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export PATH=$HOME/.local/bin:$PATH
export PC_ID=$(uname -a)

if  grep -qi manjaro <<< "$PC_ID"; then
    export WALLPAPERS="/mnt/storage/pictures/Wallpaper/"
    export QBL_ASYNC=false
fi

export FOTM_TERM="alacritty"
