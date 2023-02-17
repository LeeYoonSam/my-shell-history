#!/bin/bash

filename='company2.txt'

while read -r line
do
    echo $line
done < $filename