#!/bin/env bash

if [[ $FANCY_COLORS = true ]]; then
    function print_nnn(){
        [[ -n $NNNLVL ]] && echo '\[\033[38;5;163m\]'N$NNNLVL'\[\033[m\]'
    }
else
    function print_nnn(){
        [[ -n $NNNLVL ]] && echo '\[\033[95m\]'N$NNNLVL'\[\033[m\]'
    }
fi

# Test if sourced or ran
if $(return 0 2>/dev/null); then
	_add_prompt pre print_nnn
else
	print_nnn
fi
