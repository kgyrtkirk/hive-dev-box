#_hive_dev_box_complete () { COMPREPLY+=( $(compgen -W "`docker ps --format '{{.Names}}'`" -- $2) );} 


_hive_dev_box_complete () {
    local cur prev words cword
    _init_completion || return

    COMPREPLY=( )
    case "$prev" in
        enter)
            words="`docker ps -a --format '{{.Names}}'`"
	;;
        run)
        ;;
        hdb)
            words="enter run"
        ;;
    esac
    COMPREPLY+=( $(compgen -W "$words" -- $2) );
}

complete -F _hive_dev_box_complete hdb

# urgent stuff

function get_active_wid() {
    if [ "$DISPLAY" != "" ]; then
        xprop -root _NET_ACTIVE_WINDOW|cut -d ' ' -f5
    fi
}

function window_urgent() { wmctrl -i -r $WID   -b add,demands_attention; }
function urgent() { wmctrl -i -r $WID   -b add,demands_attention; backburner $HOSTNAME;}

function urgent_prompt_command() {
    local last_ret=$?
    active_window=`get_active_wid`
    window_urgent
    if [ "$last_ret" != 0 ];then
        backburner  $HOSTNAME
        return
    fi
    [ "$LAST_CMD_START" == "" ] && return
    cmd_time=$[ $EPOCHSECONDS - $LAST_CMD_START ]
    if [ $cmd_time -gt 60 ]; then
        backburner $HOSTNAME
    fi
    export LAST_CMD_START=
}

export LAST_CMD_START=
function enable_urgent_on_fail() {
    if [ "$DISPLAY" == "" ]; then
        echo "warn: DISPLAY not set; urgent_on_fail disabled!"
        return
    fi
    export WID=`get_active_wid`
    export PS0+='${PS1:$(( LAST_CMD_START=$EPOCHSECONDS )):0}'
    export PROMPT_COMMAND+='urgent_prompt_command;'

}

