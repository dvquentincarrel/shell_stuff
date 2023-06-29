unalias -a

# ===== Basics =====  

alias egrep='egrep --colour=auto' #COLORS
alias fgrep='fgrep --colour=auto' #MORE COLORS
alias grep='grep --colour=auto' #EVEN MORE COLORS
alias ls='ls --color=auto --group-directories-first' #STILL MORE COLORS
alias cp="cp -i" # confirm before overwriting something
alias df='df -h' # human-readable sizes
alias np='nano -w PKGBUILD'
alias more=less

# ===== Redefines =====  

alias free='free -h' #blocks = mega
alias df='df -h' #human readable sizes
alias du='du -ch' #human readable AND grand total at the end
alias ll='ls -lhX '
alias lla='ls -laXh '
alias llaa='ls -dhlX .*'
alias bcd='xpr .'
alias rm='rm -vi'
alias mv='mv -i'
alias cal='cal -my'
alias which='which -a'
alias vim='nvim'
alias sqlite3='sqlite3 -header -column'

# ===== New aliases =====  

alias win_network='sudo virsh net-start default'
alias monitor-swap='xrandr --output HDMI-0 --primary --left-of DP-1'
alias clip='xclip -sel clip'
alias reload='source ~/.local/bin/sh_setup'
alias xv='xvtouch'
alias pcl='echo -n $PWD | clip; echo "$PWD sent to clipboard"'
alias rp="repeat"
alias grepp='grep --colour=auto -P'
alias pcd="cd -P"
alias lg="ll -a --color=always | grep -i --color=never"
alias functions="declare -F | cut -d' ' -f 3"
alias mpcd='cd $(mktemp -d XXXXX)' # "Make Perishable cd"
alias nbk='ln -nsf "$PWD" "$HOME/.config/nnn/bookmarks/000_TMP"' # Nnn BooKmark
alias fzd='cd $(find . -type d -name .git -prune -o -type d -print | fzf)'
alias tvim='vim -c "setl buftype=nofile"'

# ===== Git =====  

alias gst="git status"
alias gcomm="git commit -m"
alias gcom="git commit"
alias gad="git add"
alias gadd=gad
alias gpu="git push"
alias gpl="git pull --verbose"
alias gdt="git difftool"
alias glog="git denselog"
alias aglog="git allog"
alias pglog="git patchlog"
alias gchp="git cherry-pick"
alias gchpa="gchp --abort"
alias gchpc="gchp --continue"
alias gpgs="gchp --skip"
alias gct="git checkout"
alias groot='cd $(git root)'
alias gfh='git fetch'

# shells are preceeded by a hyphen if they're login shells
if [[ -n "$ZSH_VERSION" ]]; then
	alias reload_all='source ~/.zshrc'
elif [[ -n "$BASH_VERSION" ]]; then
	alias reload_all='source ~/.bashrc'
else
	printf -v msg '"%b" shell unknown: could not set alias reload_all' "$0"
	echo $msg
	alias reload_all='echo $msg'
fi

if [ "$MACHINE" = "local" ]; then
    source local_aliases.sh
elif [ "$MACHINE" = "opi" ]; then
    source opi_aliases.sh
fi
