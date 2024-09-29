#!/bin/bash
# Short for toggle picom
# (But actually supports compton too)
compositor=$(which picom || which compton)
if [[ -z $compositor ]]; then
	notify-send "Neither picom nor compton found"
	exit 1
fi
name=$(awk -F/ '{print $NF}' <<< $compositor)

pid=$(pgrep -x $name) 
if [ -n "$pid" ];then
	kill $pid
	echo terminating "$compositor"
	notify-send "killing $name" -t 675
else
	echo starting "$compositor"
	notify-send "launching $name" -t 675
	$compositor -b --backend glx
fi
