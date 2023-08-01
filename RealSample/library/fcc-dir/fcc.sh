#!/usr/bin/env bash

function fcc {
    local FCC_DIRECTORY="$HOME/.config/fcc-dir"
    local INDEX="$FCC_DIRECTORY/index"
    local PREVIEW="ls -alh"

    function __fcc_help() {
        printf "
[ fcc ] - favorite command collection

usage: fcc [add | select | remove | list | clean | help]
short: fcc [a   | s      | rm     | l    | c     | h   ]

Examples
fcc add     => Add command to fcc index file.
fcc select  => Add command to fcc from history index file.
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
            "help"|"h")
                __fcc_help;;
            "add"|"a")
                __fcc_add_command;;
            "remove"|"rm")
                __fcc_remove_command;;
            "select" |"s")
                __fcc_select_command;;
            *)
                __fcc_get_list
                local TARGET_COMMAND=$(__fcc_get_target_command)
                if [ ! "$TARGET_COMMAND" = "" ]; then
                    echo "Run $TARGET_COMMAND"
                    eval $TARGET_COMMAND
                fi
                ;;
        esac
    }

    function __fcc_add_command() {
        local CURRENT_COMMAND=$(history -1 | cut -d' ' -f4-)
        echo "Current Command: $CURRENT_COMMAND"
        echo "$CURRENT_COMMAND" > $INDEX.temp
        cat $INDEX >> $INDEX.temp

        local successMessage="Added => $CURRENT_COMMAND"
        checkDuplicationCommand $successMessage
    }

    function __fcc_get_list() {
        grep -v '^ *$' $INDEX
    }

    function __fcc_get_target_command() {
        local TARGET_COMMAND=$(__fcc_get_list | cat | fzf -m);
        echo $TARGET_COMMAND | sort -r
    }

    function __fcc_remove_command() {
        echo -n '' > $INDEX.temp
        echo $(
            for command in `__fcc_get_list | fzf -m` ; do
                grep -v $command $INDEX >> $INDEX.temp
                echo "Removed => $command"
            done
        )
        __fcc_save_temp_to_index
    }

    function __fcc_select_command() {
        local HISTORY_COMMAND=$(history -15 | cut -d' ' -f4- | fzf -m | sort -r);

        echo $(
            for command in $HISTORY_COMMAND ; do
                echo "$command" > $INDEX.temp
                cat $INDEX >> $INDEX.temp

                local successMessage="Added => $command"
                checkDuplicationCommand $successMessage
            done
        )
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
        echo $1
    }

    function checkDuplicationCommand() {
        # 커맨드 정렬 및 중복 명령 찾기
        sorted_commands=$(sort $INDEX.temp)
        duplicate_commands=$(echo "$sorted_commands" | uniq -d)
    
        if [ -z "$duplicate_commands" ]; then
            __fcc_save_temp_to_index $1
        else
            # 중복된 라인 출력
            while IFS= read -r command; do
                IS_DUPLICATED=true
                echo "Duplicated => $command"
            done <<< "$duplicate_commands"
        fi
    }

    __fcc_main $@
}