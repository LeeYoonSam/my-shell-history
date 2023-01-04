#!/bin/bash

# Read file line by line

if [ $# -gt 0 ]; then
  filename=$1

  while read line; do
    echo $line
  done < $filename

else
  echo "Argument value is missing"
fi
