#!/bin/env bash
mpv --playlist=<(tr '\0' '\n' < $XDG_CONFIG_HOME/nnn/.selection)
