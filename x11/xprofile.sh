#!/bin/sh

# Sourced by lightdm before .xsession

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

export WINIT_X11_SCALE_FACTOR=1 # Fixes issues with scaling on some software (Alacritty, Zoom, ...)
export TERM_EMULATOR=alacritty_wrapper
for file in $XDG_CONFIG_HOME/X11/*profile.*sh; do . "$file"; done

if command -v xwallpaper; then
    export WALLPAPER_SETTER='xwallpaper --zoom'
elif command -v feh; then
    export WALLPAPER_SETTER='feh --bg-fill'
fi
