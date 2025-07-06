if ! status --is-interactive
    return 0
end
# ===== Basics =====

abbr grep 'grep --colour=auto'
alias ls "$(command -v eza exa ls | head -n1 || 'ls --color=auto --group-directories-first')"
abbr cp "cp -i" # confirm before overwriting something
abbr df 'df -h' # human-readable sizes
abbr pu 'pushd'
abbr pd 'popd'
abbr more less

# ===== Redefines =====

abbr free 'free -h' #blocks = mega
abbr df 'df -h' #human readable sizes
abbr du 'du -ch' #human readable AND grand total at the end
abbr ps "ps -o pid,ppid,pgid,tty,stat,thcount,nice,pcpu,pmem,etime,cputime,cmd"
abbr pgrep "pgrep -li"
abbr ll 'ls -lh '
abbr lla 'ls -lah '
abbr llaa 'ls -dhl .*'
abbr rm 'rm -vi'
abbr mv 'mv -i'
abbr cal 'cal -my'
abbr ping 'ping -D -O'
abbr vim 'nvim'
abbr lazygit 'TERM=tmux CONFIG_DIR=$HOME/.config/lazygit lazygit'

# ===== New aliases =====

abbr pcd "cd -P"
abbr lg "ll -a --color=always | grep -i --color=never"
abbr mpcd 'cd $(mktemp -d XXXXX)' # "Make Perishable cd"
abbr nbk 'ln -nsf "$PWD" "$HOME/.config/nnn/bookmarks/000_TMP"' # Nnn BooKmark
abbr xo 'xdg-open'
abbr penv 'source $(find -type f -name activate -path "*venv*/bin*" | head -n1)'
