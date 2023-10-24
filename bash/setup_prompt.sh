[[ $QBL_LOADED -ne '1' ]] && which qbl_init >/dev/null && source qbl_init
QBL_LOADED=1
if ! grep -q '\bshare_hist\b' <<< $PROMPT_COMMAND ; then
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;} share_hist"
fi
