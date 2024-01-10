export FZF_DEFAULT_OPTS='
--height 50%
--bind "ctrl-v:execute($EDITOR {})"
--bind "ctrl-d:execute(dragon {+})"
--bind "ctrl-e:preview-down"
--bind "ctrl-y:preview-up"
--bind "ctrl-p:toggle-preview"
--ansi
--preview="fzf_preview.bash {}"
--multi
--reverse
--color "hl:#FFAA00,hl+:#FFAA00"
'
