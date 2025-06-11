if ! status --is-interactive
    return 0
end

if $FANCY_COLORS = true
    set -l edges_fg_color '38:5:234'
    set -l bg_color '48:5:234'
    set -l delim_fg_color '97'
    set __lhs "\x1b["$edges_fg_color"m\x1b[0;"$bg_color'm'
    set __delim "\x1b["$bg_color";"$delim_fg_color'm▕ \x1b[0:'$bg_color'm'
    set __rhs "\e[0;"$edges_fg_color'm\x1b[m'

    set __PY_COLOR '38;2;255;222;59'
    set __NNN_COLOR '38;5;163'

else
    set -l delims '< ' ' | ' ' >'
    set -l names '__lhs' '__delim' '__rhs'
    # Colors lhs, delim & rhs yellow
    for i in 1 2 3
        set $names[$i] (string join '' "\x1b[33m" $delims[$i] "\x1b[m")
    end

    set __PY_COLOR '33'
    set __NNN_COLOR '95'
end

if $FANCY_SYMBOLS = true
    set __HIST '🕮 '
    set __PY 
else
    set __HIST 'H'
    set __PY venv
end

function __status_prompt
    if test $argv[1] != 0 
        printf $argv[1]
    end
end

function __th_prompt
    if set -q fish_history && string match -q $fish_history ''
        printf "\e[31m%s\e[m" $__HIST
    end
end

function __python_prompt
    if test -n "$VIRTUAL_ENV"
        printf "\e[%sm%s\e[m" $__PY_COLOR $__PY
    end
end

function __nnn_prompt
    if test -n "$NNNLVL"
        printf "\e[%sm%s\e[m" $__NNN_COLOR $NNNLVL
    end
end

function __dir_prompt
    printf "\e[36m$(prompt_pwd --dir-length 15 --full-length-dirs 3)\e[m"
end

# __git_prompt secluded in its own file

function fish_prompt
    set -l _status $status
    set -l core (string join $__delim (__status_prompt $_status) (__th_prompt) (__python_prompt) (__nnn_prompt) (__dir_prompt) (__git_prompt))
    printf "$__lhs$core$__rhs "
end
