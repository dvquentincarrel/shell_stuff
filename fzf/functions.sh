# Fzf to a directory
function fzd {
    if [[ $1 == '-a' ]]; then
        path=$(find . -type d -name .git -prune -o -type d -print | fzf --preview='tree -C {}')
    else
        path=$(find . -type d -path '*/.*' -prune -o -type d -print | fzf --preview='tree -C {}')
    fi
    if [[ -n $path ]]; then
        pushd "$path"
    fi
}
export -f fzd
