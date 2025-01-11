#!/bin/env bash

function print_nnn(){
	[[ -n $NNNLVL ]] && echo '\[\033[35m\]'N$NNNLVL'\[\033[m\]'
}

# Test if sourced or ran
if $(return 0 2>/dev/null); then
	_add_prompt pre print_nnn
else
	print_nnn
fi
