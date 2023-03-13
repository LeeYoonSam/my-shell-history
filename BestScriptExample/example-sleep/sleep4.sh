#!/bin/bash

n=1
while [ $n -lt 5 ]
do
    echo "the value of n is now $n"
    sleep 2
    echo ' '
    ((n=$n+1))
done