export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 3) # yellow (bold) 
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 18; tput setab 248) # cyan on blue (status bar)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white (underline) 
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

if [[ "$MACHINE" = "local" ]]; then
    # Made for : less 608 (PCRE2 regular expressions)
    export LESS='-R -j5 -#5 -i -J -N -M --incsearch -S --line-num-width 4 -z-3 -g'
elif [[ "$MACHINE" = "opi" ]]; then
    export LESS='-R -j5 -#5 -i -J -N -M -S -z-3 -g -a'
fi
# -R: ansi color chars
# -j5: 5 lines around jump target on search
# -#5: 5 chars when horizontal scroll
# -i: smart ignorecase
# -J: status column at the left (matching lines on search & co)
# -N: line numbers
# -M: verbosest prompt
# -S: long lines are truncated instead of wrapped
# -z-3: edges of the scrolling window (idk)
# -g: on found search, only highlight closest string
# -a: searches start at the top or bottom of the whole document
