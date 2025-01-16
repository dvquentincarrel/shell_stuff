export FZF_HELP=\
"[93m^E[m   open file with "'$EDITOR'"
[93m^O[m   open file with xdg-open
[93m^P[m   toggle preview
[93m^?[m   show help
[93m^↑[m   scroll preview up
[93m^↓[m   scroll preview down
[93mA-/[m  toggle line-wrap
[93m^C / ^G / ^Q / Esc[m   exit"
export FZF_DEFAULT_OPTS='
--height 50%
--bind "ctrl-e:execute($EDITOR {})"
--bind "ctrl-d:execute(dragon {+})"
--bind "ctrl-o:execute(xdg-open {})"
--bind "ctrl-p:toggle-preview"
--bind "ctrl-/:execute(fzf --height=100% --border-label=\"Help - Esc / ^C to leave\" --border=rounded --ansi --preview="" <<< $FZF_HELP)"
--info=inline
--ansi
--preview="fzf_preview.bash {}"
--preview-window=hidden
--multi
--reverse
--color "hl:#FFAA00,hl+:#FFAA00"
'
