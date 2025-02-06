#!/bin/sh
source ~/.xprofile
for file in "$XDG_CONFIG_HOME"/X11/*init.*sh; do . "$file"; done

xset r rate 250 50 # delay, rate
xset s off -dpms # Disable dpms, prevent screen from blanking
xrandr --dpi 96
setxkbmap leyaourt || setxkbmap 'us(altgr-intl)' || setxkbmap us

dunst& </dev/null
udiskie& </dev/null
exec i3 </dev/null
