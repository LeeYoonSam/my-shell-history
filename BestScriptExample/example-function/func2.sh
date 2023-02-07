#!/bin/bash

function f2() {
    local retval='Using BASH function'
    echo "$retval"
}

getval="$(f2)"
echo $getval