#!/usr/bin/env bash

function fcc {
    local FCC_DIRECTORY="$HOME/.config/fcc-dir"
    local INDEX="$FAV_DIRECTORY/index"
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
        
        # controller
        case $1 in
            "help"|"-h")
                __fcc_help;;
            *)
                local TARGET_PATH=$(__fcc_get_target_path)
                if [ ! "$TARGET_PATH" = "" ]; then
                    cd $TARGET_PATH
                fi
                ;;
        esac
        
    }

    function __fcc_get_list() {
        grep -v '^ *$' $INDEX
    }

    function __fcc_get_target_path() {
        local TARGET_PATH=$( \
            (printParentsRecursive ; echo '' ; __fcc_get_list) \
            | cat \
            | fzf --preview="echo {} | xargs $PREVIEW" \
        );
        echo $TARGET_PATH

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

    __fcc_main $@
}