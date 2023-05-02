export conf=~/config/
export bin=~/bin/
if [ "$MACHINE" = "local" ]; then
    source local_variables.sh
elif [ "$MACHINE" = "opi" ]; then
    source opi_variables.sh
fi

export HISTCONTROL="ignoreboth" # If starting with a space, if same command as previously
export HISTIGNORE="history*"
export HISTSIZE=5000000
export PAGER='less -S'
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export EDITOR=/bin/vim
# export TERMINAL=alacritty # What's this for ?
export CALCHISTFILE=/dev/null # To disable the use of a history file for /bin/calc
export LESSHISTFILE=/dev/null # Same thing for /bin/less
export HSYNCW=true # push history lines (after each command)
export HSYNCR=false # pull history lines (after each command)
