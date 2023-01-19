#!/bin/bash

# Reading all arguments values
argvals=("$@")

# Check the total number of arguments
if [ $# -gt 2 ]
then
    # Calculate the sum of three command line arguments
    sum=$((${argvals[0]}+${aragvals[1]}+${argvals[2]}))
    echo "The sum of 3 command line arguments is $sum"
fi