# Fzf to a directory

function _fzd_getfiles {
	if [[ $1 == '-a' ]]; then
        local prune_type="-name"
        local prune_target=".git"
        shift
	else
        local prune_type="-path"
        local prune_target="*/.*"
	fi
	local modmin=${1:-0}
	local modmax=${2:-0}
	local min=$((1 + modmin > 0 ? 1 + modmin : 1))
	local max=$((5 + modmax > modmin ? 5 + modmax : modmin))
    find . -mindepth $min -maxdepth $max -type d $prune_type "$prune_target" -prune -o -type d -print
}
export -f _fzd_getfiles

function fzd {
    local help_msg
    read -d '' help_msg <<-EOF
	Usage: fzd [-a] [MINMOD] [MAXMOD]
	Use fzf to select a directory with a depth between 1 and 5, hiding hidden dirs by default.
	Exemple: fzd -a 2 -1
	Params:  -a        only hide .git dirs
	         MINMOD    how much to add/subtract to the minimum depth
	         MAXMOD    how much to add/subtract to the maximum depth
	EOF
    if [[ $1 == '-h' ]]; then
        echo "$help_msg"
        return 0
    fi
	local path=$(_fzd_getfiles $@ | \
		fzf --preview='tree -C {}'
	)
	if [[ -n $path ]]; then
		pushd "$path"
	fi
}
export -f fzd
