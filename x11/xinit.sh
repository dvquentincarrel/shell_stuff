#!/bin/bash
source ~/.profile
if  grep -qi manjaro <<< "$PC_ID"; then
    xrandr --output HDMI-0 --primary --left-of DP-1
elif  grep -qi manjaro <<< "$PC_ID"; then
    xrandr --output HDMI-1 --left-of eDP-1 --primary
fi

xset r rate 250 50 # delay, rate
setxkbmap leyaourt || setxkbmap 'us(altrg-intl)' || setxkbmap us
export WINIT_X11_SCALE_FACTOR=1 # Fixes issues with scaling on some software (Alacritty, Zoom, ...)

exec i3 
