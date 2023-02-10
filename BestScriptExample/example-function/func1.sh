#!/bin/bash

function f1() {
    retval='I like programming'
}

retval='I hate programming'
echo $retval
f1
echo $retval