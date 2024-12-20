#!/bin/sh

# Sourced by lightdm before .xsession

if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

export WINIT_X11_SCALE_FACTOR=1 # Fixes issues with scaling on some software (Alacritty, Zoom, ...)

if which xwallpaper; then
    export WALLPAPER_SETTER='xwallpaper --zoom'
elif which feh; then
    export WALLPAPER_SETTER='feh --bg-fill'
fi
