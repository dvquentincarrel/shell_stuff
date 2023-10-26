export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/ripgrep.rc

function _print_grep_context {
	fileField=${2:-1}
	
	data=$(tr -s ' ' <<< $1 | cut -f $fileField -d' ')
	
	filePath=$(cut -f1 -d':' <<< $data)
	lineNum=$(cut -f2 -d':' <<< $data)
	
	surround=$((LINES / 2))
	low=$((lineNum - surround ))
	low=$((low < 1 ? 1 : low))
	high=$((lineNum + surround))
	
	bat -n --color always "$filePath" -r ${low}:${high} -H $lineNum
}
export -f _print_grep_context

function _vimopen_grep_output {
	data=$(tr -s ' ' <<< $1 | cut -f1 -d' ')
	filePath=$(cut -f1 -d':' <<< $data)
	lineNum=$(cut -f2 -d':' <<< $data)
	echo "$filePath" +"$lineNum"
}
export -f _vimopen_grep_output

function fzr {
	fzf --height=100% \
		--preview="_print_grep_context {}" \
		--preview-window=top,50% \
		--bind='enter:execute(_vimopen_grep_output {} | xargs -o vim)'
}
