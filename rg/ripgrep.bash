export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/ripgrep.rc

# Feed file -or portion of it if too big- to bat
function _print_grep_context {
    file="$1"
    line_num="$2"
    total_lines=$(awk 'END {print NR}' < "$1")
    if ((total_lines > 5000)); then
        awk "NR==$line_num"' {print "\033[7m" $0 "\033[m"; next} {print $0}' "$file"
        return 0
    fi

    offscreen_offsets=$((FZF_PREVIEW_LINES * 3))

    # Truncates output, can save a lot of time on big files. Lower bound bottoms
    # out a 0, upper bound tops at file length
    lower_bound=$((line_num - offscreen_offsets))
    lower_bound=$((lower_bound > 0 ? lower_bound : 0))
    upper_bound=$((line_num + offscreen_offsets))
    upper_bound=$((upper_bound < total_lines ? upper_bound : total_lines))

    # TODO: caching
    for ((i=0; i<$lower_bound; i++)); do echo; done # Ensures coherent scroll offsets
    bat -n --color always "$file" -r $lower_bound:$upper_bound -H $line_num
}
export -f _print_grep_context

function _vimopen_grep_output {
    if [[ $# -gt 1 ]]; then
        echo "$@" | tr ' ' '\n' > /tmp/frg.omod
        nvim -n /tmp/frg.omod
    else
        # file:line => file +line; if only a single file selected
        nvim ${1/:/ +}
    fi
}
export -f _vimopen_grep_output

function frg {
    rg "$@" --color=always | fzf -0 -d':' --height=100% \
        --preview="_print_grep_context {1} {2}" \
        --preview-window=top,50%,+{2}/2,wrap \
        --bind='enter:execute(_vimopen_grep_output {+1..2})'
    if [[ $? -eq 1 ]]; then
        echo -e "\x1b[31mNo match found for \x1b[0m'$@'"
        return 1
    fi
}
export -f frg
