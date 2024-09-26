#!/bin/sh
if uname -a | grep -qi manjaro; then
    xrandr --output HDMI-0 --primary --left-of DP-1
elif uname -a | grep -qvi manjaro; then
    xrandr --output HDMI-1 --left-of eDP-1
    xrandr --output eDP-1 --primary
fi

xset r rate 250 50 # delay, rate
xset s off -dpms # Disable dpms, prevent screen from blanking
setxkbmap leyaourt || setxkbmap 'us(altgr-intl)' || setxkbmap us

exec i3
