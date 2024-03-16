#!/bin/sh
id=$(uname -a)
if echo "$id" | grep -qi manjaro; then
        xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --off --output DP-1 --mode 1920x1080 --pos 1920x0 --rotate normal
elif echo "$id" | grep -qi ubuntu; then
        xrandr --output HDMI-1 --left-of eDP-1 --primary
fi
