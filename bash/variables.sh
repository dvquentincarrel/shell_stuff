# History
## Used by sync_hist
export HSYNCW=true # push history lines (after each command)
export HSYNCR=false # pull history lines (after each command)
## Used by bash
export HISTCONTROL="ignoreboth" # If starting with a space, if same command as previously
export HISTTIMEFORMAT="%y/%m/%d-%H:%M:%S " # YY/MM/DD format to timestamp entries
export HISTSIZE=5000000
## General
export CALCHISTFILE=/dev/null # To disable the use of a history file for /bin/calc
export LESSHISTFILE=/dev/null # Same thing for /bin/less

export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc # Default location is ~/.inputrc
export FOTM_TERM="alacritty msg create-window" # Used for terminal popups

export TMPDIR=${TMPDIR:-${XDG_RUNTIME_DIR:-/tmp}}

# Paging
export PAGER='less -S'
nvp=$(command -v nvim); vp=$(command -v vim)
export EDITOR=${nvp:-$vp} # tries to set nvim as default editor, fallsback to vim
if [[ -n $nvp ]]; then
    export MANPAGER="nvim +Man!"
elif [[ -n $vp ]]; then
    export MANPAGER="vim +MANPAGER --not-a-term -"
fi

#export TERM_ITALICS="true" #
