#!/usr/bin/env bash

function fcc {
    local FCC_DIRECTORY="$HOME/.config/fcc-dir"
    local INDEX="$FCC_DIRECTORY/index"
    local PREVIEW="ls -alh"

    function __fcc_help() {
        printf "
[ fcc ] - favorite command collection

usage: fcc [add | remove | list | clean  | help]
short: fcc [a   | rm     | l    | c     | help]

Examples
fcc add     => Add command to fcc index file.
fcc remove  => Remove selected command in index file.
fcc list    => Print index file.
fcc clean   => Remove invalid directories in index file.
fcc help    => Show help.
\n"
    }

    function __fcc_main() {
        # create_index
        if [ ! -d "$FCC_DIRECTORY" ]; then
            mkdir -p $FCC_DIRECTORY
        fi
        if [ ! -f "$INDEX" ]; then
            touch $INDEX
        fi

        # controller
        case $1 in
            "help"|"-h")
                __fcc_help;;
            "add"|"a")
                __fcc_add_command;;
            "remove"|"rm")
                __fcc_remove_command;;
            *)
                __fcc_get_list
                local TARGET_COMMAND=$(__fcc_get_target_command)
                if [ ! "$TARGET_COMMAND" = "" ]; then
                    echo "Run $TARGET_COMMAND"
                    $TARGET_COMMAND
                fi
                ;;
        esac
    }

    function __fcc_add_command() {
        local CURRENT_COMMAND=$(history -1 | awk '{print $2}')
        echo "current_command: $CURRENT_COMMAND"
        echo "$CURRENT_COMMAND" > $INDEX.temp
        cat $INDEX >> $INDEX.temp
        __fcc_save_temp_to_index
        echo "Added => $CURRENT_COMMAND"
    }

    function __fcc_get_list() {
        grep -v '^ *$' $INDEX
    }

    function __fcc_get_target_command() {
        local TARGET_COMMAND=$(__fcc_get_list | cat | fzf -m);
        echo $TARGET_COMMAND | sort -r
    }

    function __fcc_remove_command() {
        echo -n '' >$INDEX.temp
        echo $(
            for command in `__fcc_get_list | fzf -m` ; do
                grep -v $command $INDEX >> $INDEX.temp
                echo "Removed => $command"
            done
        )
        __fcc_save_temp_to_index
    }

    function printParentsRecursive() {
        echo "$(
            local pre=""
            for loc in $(echo $PWD | sed 's,/,\'$'\n/,g'); do
                local pre="$pre$loc"
                echo $pre
            done | sort -r
            
        )"
    }

    function __fcc_save_temp_to_index() {
        sort $INDEX.temp | uniq > $INDEX
    }

    __fcc_main $@
}