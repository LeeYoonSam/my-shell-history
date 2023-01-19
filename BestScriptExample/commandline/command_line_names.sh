#!/bin/bash

for arg in "$@"
do
    index=$(echo $arg | cut -d = -f 1)
    val=$(echo $arg | cut -d = -f 2)

    case $index in
        X) x=$val ;;
        Y) y=$val ;;
        *)
    esac
done

((result=x+y))
echo "X+Y=$result"