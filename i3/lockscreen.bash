#!/bin/bash
logger "Lock at $(date +'%H:%M:%S %d-%m-%Y')"
i3lock \
    --ignore-empty-password \
    --show-failed-attempts \
    $(pgrep picom && echo '--color 00000000' || echo '--blur 5') \
    --inside-color 00000000 \
    --insidever-color 00000000 \
    --insidewrong-color 00000000 \
    --ring-color F96322 \
    --ringver-color FCE344 \
    --ringwrong-color F92222 \
    --verif-color FFFFFF \
    --wrong-color FFFFFF \
    --modif-color FFFFFF \
    --line-uses-inside \
    --wrong-text '' \
    --noinput-text ''
