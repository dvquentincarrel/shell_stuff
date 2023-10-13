#!/bin/bash
# Short for toggle picom
# (But actually supports compton too)
if which picom &>/dev/null; then
	compositer=$(which picom | tail -n 1)
	name=picom
elif which compton &>/dev/null; then
	compositer=$(which compton | tail -n 1)
	name=compton
else
	notify-send "Neither picom nor compton found"
	exit 1
fi

pid=$(pgrep -x $name) 
if [ -n "$pid" ];then
	kill $pid
	echo terminating
	notify-send "killing $name" -t 500
else
	echo launching
	notify-send "launching $name" -t 500
	$compositer -b --config $XDG_CONFIG_HOME/picom.conf --backend glx
fi

export > /tmp/exp2
echo $- >> /tmp/exp2
