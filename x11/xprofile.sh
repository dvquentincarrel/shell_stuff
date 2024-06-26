#!/bin/sh

# Sourced by lightdm before .xsession

if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

export WINIT_X11_SCALE_FACTOR=1 # Fixes issues with scaling on some software (Alacritty, Zoom, ...)

export XDG_DATA_DIRS=${XDG_DATA_DIRS:-"/usr/local/share:/usr/share"}
export XDG_PICTURES_DIR="/mnt/storage/pictures"
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if grep -v "$HOME/.local/bin" <<< "$PATH" &> /dev/null; then
    export PATH=$HOME/.local/bin:$PATH
fi
