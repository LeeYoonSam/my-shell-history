#!/bin/bash

filename='company.txt'
n=1

while read line
do
    # Reading each line
    echo "line No. $n : $line"
    n=$((n+1))
done < $filename
