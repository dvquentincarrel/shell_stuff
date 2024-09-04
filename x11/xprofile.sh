#!/bin/sh

# Sourced by lightdm before .xsession

if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

export WINIT_X11_SCALE_FACTOR=1 # Fixes issues with scaling on some software (Alacritty, Zoom, ...)
