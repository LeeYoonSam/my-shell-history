#!/bin/bash

# Take the path value from the input
read -p 'Enter the valid path: ' path

# Check the input values is a directory or not
if [ -d $path ]; then
    echo "$path is a directory"
# Check the input values is a file or not
elif [ -f $path ]; then
    echo "$path is a file"
else
    echo "Invalid path."
fi