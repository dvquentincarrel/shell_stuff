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
alias man='export COLUMNS=$((COLUMNS - 7)); man'
alias lazygit='(TERM=tmux; lazygit)'

# ===== New aliases =====  

alias win_network='sudo virsh net-start default'
alias monitor-swap='xrandr --output HDMI-0 --primary --left-of DP-1'
alias clip='xclip -sel clip'
alias xv='xvtouch'
alias rp="repeat"
alias grepp='grep --colour=auto -P'
alias pcd="cd -P"
alias lg="ll -a --color=always | grep -i --color=never"
alias functions="declare -F | cut -d' ' -f 3"
alias mpcd='cd $(mktemp -d XXXXX)' # "Make Perishable cd"
alias nbk='ln -nsf "$PWD" "$HOME/.config/nnn/bookmarks/000_TMP"' # Nnn BooKmark
alias tvim='vim -c "setl buftype=nofile"'
alias alarm='mpv ~/opi/alarm.mp3'
alias xop='xdg-open'

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

complete -W '$(git rev-parse 2>/dev/null && git branch --format "%(refname:short)" | grep -v "HEAD detached at"; git tag --list)' gct
complete -W '$(git rev-parse 2>/dev/null && git status --short | sed "s/  / /" | cut -d" " -f2 )' gadd

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
