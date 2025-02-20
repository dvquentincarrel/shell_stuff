#!/bin/bash
logger "Lock at $(date +'%H:%M:%S %d-%m-%Y')"
killall -SIGUSR1 dunst # pause notifications
swaylock -c 000000BB && killall -SIGUSR2 dunst # resume
logger "Unlock at $(date +'%H:%M:%S %d-%m-%Y')"
