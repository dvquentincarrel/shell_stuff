#!/bin/env bash

if [[ $FANCY_SYMBOLS = true ]]; then __PY=; else __PY=venv; fi

if [[ $FANCY_COLORS = true ]]; then
    function print_python(){
        if [[ -n $VIRTUAL_ENV ]]; then
            echo '\[\033[38;2;255;222;59m\]'$__PY'\[\033[m\]'
        fi
    }
else
    function print_python(){
        if [[ -n $VIRTUAL_ENV ]]; then
            echo '\[\033[33m\]'$__PY'\[\033[m\]'
        fi
    }
fi

# Test if sourced or ran
if $(return 0 2>/dev/null); then
	_add_prompt pre print_python
else
	print_python
fi
