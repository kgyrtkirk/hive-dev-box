#_hive_dev_box_complete () { COMPREPLY+=( $(compgen -W "`docker ps --format '{{.Names}}'`" -- $2) );} 


_hive_dev_box_complete () {
    local cur prev words cword
    _init_completion || return

    COMPREPLY=( )
    case "$prev" in
        enter)
            words="`docker ps --format '{{.Names}}'`"
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