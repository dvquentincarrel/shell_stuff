# Fzf to a directory

function fzd {
	local help_msg
	read -d '' help_msg <<-EOF
	Usage: fzd
	Use fzf & bf to select a directory
	EOF
	if [[ $1 == '-h' ]]; then
		echo "$help_msg"
		return 0
	fi
	local path=$(
		bf | fzf --preview='tree -C {}'
	)
	if [[ -n $path ]]; then
		pushd "$path"
	fi
}
export -f fzd
