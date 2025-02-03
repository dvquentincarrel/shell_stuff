# Modular-ish prompt that can easily be extended by other programs

# Tries to figure whether to enable or disable the fancy shmancies
if [[ $TERM =~ ^linux ]]; then
    export FANCY_COLORS=false
    export FANCY_SYMBOLS=false
elif [[ -n $TMUX ]] && [[ $(tmux display -p '#{client_tty}') =~ /dev/tty[0-9] ]]; then
    export FANCY_COLORS=false
    export FANCY_SYMBOLS=false
else
    export FANCY_COLORS=true
    export FANCY_SYMBOLS=true
fi

# Adds a function to the prompt construction
function _add_prompt(){
	if [[ $1 = pre ]]; then
		__prompt=(
			$2
			"${__prompt[@]}"
		)
	elif [[ $1 = post ]]; then
		__prompt=(
			"${__prompt[@]}"
			$2
		)
	fi
}

__cls=('\[\033[33m\]' '\[\033[m\]')
__dlm=(\< \| \>)
names=(__lhs __mid __rhs)
for ((i=0; i<3; i++)); do
	printf -v ${names[$i]} "${__cls[0]}${__dlm[$i]}${__cls[1]}"
done

__prompt=(
	'echo "$__ret"'
	'echo "\[\033[36m\]\w"'
)
# Joins output of every func in __prompt, separated by $__mid, wrapped in $__lhs and $__rhs
function _gen_prompt(){
	__ret=$?

    # Constructs blocks to known which to join
	len=${#__prompt[@]}
	for ((i=0; i<len; i++)); do
        local old_output="$output"
		local output=$(eval ${__prompt[$i]})
		if [[ -n $output ]]; then
            local blocks+=("$output")
		fi
	done

    PS1="$__lhs $(join_by " $__mid " "${blocks[@]}") $__rhs "
}

PROMPT_COMMAND+=(_gen_prompt)
