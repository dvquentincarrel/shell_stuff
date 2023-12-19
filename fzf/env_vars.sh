export FZF_DEFAULT_OPTS='
--height 50%
--bind "ctrl-v:execute($EDITOR {})"
--bind "ctrl-d:execute(dragon {+})"
--bind "ctrl-e:preview-down"
--bind "ctrl-y:preview-up"
--bind "ctrl-/:change-preview-window(hidden|)"
--ansi
--preview="$(which bat batcat false 2>/dev/null | head -n1) -p -r :50 --color=always {} 2>/dev/null || head -n 50 {} 2>/dev/null"
--multi
--reverse
--color "hl:#FFAA00,hl+:#FFAA00"
'
