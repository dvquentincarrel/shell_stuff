export conf=~/config/
export bin=~/bin/
if [ "$MACHINE" = "local" ]; then
    source local_variables.sh
elif [ "$MACHINE" = "opi" ]; then
    source opi_variables.sh
fi

export HISTCONTROL="ignoreboth" # If starting with a space, if same command as previously
export HISTSIZE=5000000
export PAGER='less -S'
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
nvp=$(command -v nvim); vp=$(command -v vim)
export EDITOR=${nvp:-$vp} # tries to set nvim as default editor, fallsback to vim
export CALCHISTFILE=/dev/null # To disable the use of a history file for /bin/calc
export LESSHISTFILE=/dev/null # Same thing for /bin/less
export HSYNCW=true # push history lines (after each command)
export HSYNCR=false # pull history lines (after each command)
export TERM_ITALICS="true"
