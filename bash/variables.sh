# History
## Used by bash
export HISTCONTROL="ignoreboth" # If starting with a space, if same command as previously
export HISTTIMEFORMAT="%y/%m/%d-%H:%M:%S " # YY/MM/DD format to timestamp entries
export HISTSIZE=5000000
export HISTIGNORE='th'
## General
export CALCHISTFILE=/dev/null # To disable the use of a history file for /bin/calc
export LESSHISTFILE=/dev/null # Same thing for /bin/less

export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc # Default location is ~/.inputrc
export FOTM_TERM="alacritty msg create-window" # Used for terminal popups

export TMPDIR=${TMPDIR:-${XDG_RUNTIME_DIR:-/tmp}}

# Paging
export PAGER='less -S'
shopt -u expand_aliases
{
    export EDITOR=$(command -v nvim vim which vi which micro which nano | head -n1)
    export VISUAL=$EDITOR
} 2>/dev/null
shopt -s expand_aliases
if [[ $EDITOR =~ nvim ]]; then
    export MANPAGER="nvim +Man!"
elif [[ $EDITOR =~ vim ]]; then
    export MANPAGER="vim +MANPAGER --not-a-term -"
fi
