#!/bin/bash

function fc {
    local FC_DIRECTORY="$HOME/.config/fc-dir"
    local INDEX="$FAV_DIRECTORY/index"
    local PREVIEW="ls -alh"

    function __fc_help() {

    }

    function __fc_main() {

    }

    function __fc_get_list() {
        grep -v '^ *$' $INDEX
    }

    __fc_main $@
}