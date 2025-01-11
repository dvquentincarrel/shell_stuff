#!/bin/env bash

# Enables / disables component
__GIT=true
__GIT_STASH=true
__GIT_STATUS=true

if [[ $FANCY_COLORS = true ]]; then
    __GIT_C_STAGED="\[\e[38;5;40m\]"       # Green
    __GIT_C_UNTRACKED="\[\e[38;5;197m\]"   # Red
    __GIT_C_UNSTAGED="\[\e[38;5;166m\]"    # Orange
    __GIT_C_UNMERGED="\[\e[38;5;213m\]"    # Pink
    __GIT_C_AHEAD="\[\e[38;5;14m\]"        # Cyan
    __GIT_C_BEHIND="\[\e[38;5;13m\]"       # Magenta
    __GIT_C_BRANCH="\[\e[38;5;214m\]"      # yellow
    __GIT_C_TAG="\[\e[38;5;205m\]\]"       # pale pink
    __GIT_C_DETACH="\[\e[38;5;202m\]"      # dark orange
    __GIT_C_BARE="\[\e[38;5;202m\]"        # dark orange
else
    __GIT_C_STAGED="\[\e[32m\]"     # green
    __GIT_C_UNTRACKED="\[\e[31m\]"  # red
    __GIT_C_UNSTAGED="\[\e[33m\]"   # yellow
    __GIT_C_UNMERGED="\[\e[35m\]"   # purple
    __GIT_C_AHEAD="\[\e[36m\]"      # cyan
    __GIT_C_BEHIND="\[\e[35m\]"     # purple
    __GIT_C_BRANCH="\[\e[33m\]"     # yellow
    __GIT_C_TAG="\[\e[35m\]\]"      # purple
    __GIT_C_DETACH="\[\e[31m\]"     # red
    __GIT_C_BARE="\[\e[31m\]"       # red
fi

if [[ $FANCY_SYMBOLS = true ]]; then
    __GIT_S_AHEAD="↑"
    __GIT_S_BEHIND="↓"
else
    __GIT_S_AHEAD="^"
    __GIT_S_BEHIND="v"
fi
function print_git(){
    $__GIT || return 0
    [[ $PWD = $HOME ]] && return 0
    { [[ -d git ]] || git rev-parse --show-toplevel &>/dev/null; } || return 0
    __print_ref
    $__GIT_STASH && __print_stash
    $__GIT_STATUS && __print_status
}

function __print_ref(){
    local rev=$(git tag --points-at HEAD | tail -n 1)
    local type=tag
    if [[ -z $rev ]]; then
        rev=$(git branch --show-current)
        type=branch
        if [[ -z $rev ]]; then
            rev=$(git rev-parse --short HEAD)
            type=sha
        fi
    fi
    case "$type" in
        tag)
            rev="$__GIT_C_TAG$rev";;
        branch)
            rev="$__GIT_C_BRANCH$rev";;
        sha)
            rev="$__GIT_C_DETACH$rev";;
    esac
    echo -n "$rev\[\e[m\]"
}

function __print_status(){
    local output=$(gawk '
    {
        if(NR == 1) {
            if(match($0, /ahead ([0-9]+)/, ahead_g))
                ahead=sprintf("'${__GIT_C_AHEAD//\\/\\\\}'%s'$__GIT_S_AHEAD'", ahead_g[1])
            if(match($0, /behind ([0-9]+)/, behind_g))
                behind=sprintf("'${__GIT_C_BEHIND//\\/\\\\}'%s'$__GIT_S_BEHIND'", behind_g[1])
        } else {
            if($RT ~ /^\?\?/)
                untracked+=1;
            else
                if($RT ~ /^( .|MM)/)
                    unstaged+=1;
                if($RT ~ /^(. |MM)/)
                    staged+=1;
                if($RT ~ /^(D[DU]\|U[ADU]\|A[AU])/)
                    unmerged+=1;
        }
    } END {
        if(staged)
            printf "'${__GIT_C_STAGED//\\/\\\\}'%s+", staged
        if(unstaged)
            printf "'${__GIT_C_UNSTAGED//\\/\\\\}'%s!", unstaged
        if(untracked)
            printf "'${__GIT_C_UNTRACKED//\\/\\\\}'%s?", untracked
        if(unmerged)
            printf "'${__GIT_C_UNMERGED//\\/\\\\}'%s#", unmerged
        if(length(behind) != 0 || length(ahead) != 0 )
            if(staged + unstaged + untracked + unmerged != 0) {
                printf " '${__mid//\\/\\\\}' "
            }
            printf "%s%s", ahead, behind
        }' <<< $(git status --porcelain --branch))
        if [[ -n $output ]]; then
            echo -n " $__mid $output\[\e[m\]"
        fi
}

function __print_stash(){
    echo -n " $__mid \[\e[90m\]s$(git stash list | wc -l)\[\e[m\]"
}

# Test if sourced or ran
if $(return 0 2>/dev/null); then
	_add_prompt post print_git
else
	print_git
fi
