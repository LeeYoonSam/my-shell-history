#!/bin/bash

function fc {
    local FC_DIRECTORY="$HOME/.config/fc-dir"
    local INDEX="$FAV_DIRECTORY/index"
    local PREVIEW="ls -alh"

    function __fc_help() {
        printf "
[ fc ] - favorite command collection

usage: fc [add | remove | list | clean | find | help]
short: fc [a   | rm     | l    | c     | f    | help]

Examples
fc add     => Add command to fc index file.
fc remove  => Remove selected command in index file.
fc list    => Print index file.
fc clean   => Remove invalid directories in index file.
fc help    => Show help.
\n"
    }

    function __fc_main() {
        echo "welcom to fc"
    }

    function __fc_get_list() {
        grep -v '^ *$' $INDEX
    }

    __fc_main $@
}

# todo: remove
fc