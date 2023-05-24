#
# ~/.bashrc
#

# Don't load if non-interactive
[[ $- != *i* ]]  || [[ $RCREAD == true ]] && return

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"';;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"';;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

# Prevents reloading/resourcing bashrc
RCREAD=true

#xhost +local:root > /dev/null 2>&1

# -c(ommandes) -f(iles)
complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)

shopt -s cdspell # Attempts correction on small cd typos
shopt -s checkjobs # Warns about background jobs before exiting
shopt -s checkwinsize # Updates size after each command
shopt -s cmdhist # Attempts to save multi-line commands in same hist entry
shopt -s dirspell # Attempts correction on small dirname typos during autocomplete
shopt -s expand_aliases # Expands aliases (necessary for aliases)
shopt -s globstar # Enables **
shopt -s histappend # Appends to history instead of overwriting
shopt -s lithist # Multiline delimiters is \n instead of ; in hist
shopt -s no_empty_cmd_completion # Doesn't attempt completion when line's empty
shopt -s nocaseglob # Case-insensitive pathname globbing
shopt -u huponexit # Sends SIGHUP to all jobs on shell exit
shopt -u xpg_echo # Allows echo to process things like \t, \n, ...

source ~/.local/bin/sh_setup
which qbl_init >/dev/null && source qbl_init

# Tmux "integration"
if which tmux &>/dev/null && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
	source ~/.local/bin/auto_tmux
fi
