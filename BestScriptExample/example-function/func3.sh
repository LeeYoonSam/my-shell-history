#!/bin/bash

function f3() {
    local arg1=$1

    if [[ $arg1 != '' ]]
    then
        retval='BASH function with variable'
    else
        echo 'No Argument'
    fi
}

getval1='Bash Function'
f3 $getval1
echo $retval
getval2=$(f3)
echo $getval2
