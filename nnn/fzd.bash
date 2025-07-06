#!/bin/env bash
base="$PWD"
trails=(/)
# Iteratively extracts directories from / to PWD
while [[ -n $base ]]; do
    base=${base%/*}
    trails+=($base)
done

path=$( { printf "%s\n" "${trails[@]}" | sort; bf $PWD; } | fzf --preview='tree -C -L1 {}')
[[ -z $path ]] && exit

echo -n "0c$path" > $NNN_PIPE
