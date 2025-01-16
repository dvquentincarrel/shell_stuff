# Don't load if non-interactive
[[ $- != *i* ]]  && return

PROMPT_COMMAND+=('if [[ -e $TMPDIR/bash_nohist ]]; then HISTFILE=/dev/null; else HISTFILE=~/.bash_history; fi')

if [[ ${EUID} == 0 ]] ; then
	PS1='\[\033[31m\]{\[\033[m\] $? \[\033[31m\]|\[\033[m\] \[\033[36m\]\w \[\033[31m\]}\[\033[m\]'
else
	PS1='\[\033[33m\]<\[\033[m\] $? \[\033[33m\]|\[\033[m\] \[\033[36m\]\w \[\033[33m\]>\[\033[m\]'
fi

# -c(ommandes) -f(iles)
complete -cf sudo

# Don't use multiplexers when connecting through SSH
if [[ $(ps -o comm= $PPID) = sshd ]]; then
    NOMUXER=true
fi

PROMPT_COMMAND=('history -a')

for file in $(echo ${HOME}/.config/bash/setup/* 2>/dev/null); do source $file; done
