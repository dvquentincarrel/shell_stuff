unalias -a

# ===== Basics =====

alias egrep='egrep --colour=auto' #COLORS
alias fgrep='fgrep --colour=auto' #MORE COLORS
alias grep='grep --colour=auto' #EVEN MORE COLORS
alias ls="$(command -v eza exa ls | head -n1 || 'ls --color=auto --group-directories-first')"
alias cp="cp -i" # confirm before overwriting something
alias df='df -h' # human-readable sizes
alias pu='pushd'
alias pd='popd'
alias more=less

# ===== Redefines =====

alias free='free -h' #blocks = mega
alias df='df -h' #human readable sizes
alias du='du -ch' #human readable AND grand total at the end
alias ps="ps -o pid,ppid,pgid,tty,stat,thcount,nice,pcpu,pmem,etime,cputime,cmd"
alias pgrep="pgrep -li"
alias ll='ls -lh '
alias lla='ls -lah '
alias llaa='ls -dhl .*'
alias rm='rm -vi'
alias mv='mv -i'
alias cal='cal -my'
alias which='which -a'
alias ping='ping -D -O'
alias vim='nvim'
alias man='export COLUMNS=$((COLUMNS - 7)); man'
alias lazygit='TERM=tmux CONFIG_DIR=$HOME/.config/lazygit lazygit'

# ===== New aliases =====

alias clip='xclip -sel clip'
alias xv='xvtouch'
alias grepp='grep --colour=auto -P'
alias pcd="cd -P"
alias lg="ll -a --color=always | grep -i --color=never"
alias functions="declare -F | cut -d' ' -f 3"
alias mpcd='cd $(mktemp -d XXXXX)' # "Make Perishable cd"
alias nbk='ln -nsf "$PWD" "$HOME/.config/nnn/bookmarks/000_TMP"' # Nnn BooKmark
alias xo='xdg-open'
alias penv='source $(find -type f -name activate -path "*venv*/bin*" | head -n1)'

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
