# Extract makefile rules
function _complete_make {
	if [[ -f 'Makefile' ]]; then
		mk_name='Makefile'
	elif [[ -f 'makefile' ]]; then
		mk_name='makefile'
	else
		COMPREPLY=()
		return 1
	fi
	COMPREPLY=($(grep -Po '^\S+(?=:)' $mk_name | grep "$2"))
}
complete -F _complete_make make
