#!/bin/bash

# Using continue statement to omit particular step

n=0

while [ $n -le 5 ]
do
  (( n++ ))
  if [ $n == 3 ]
  then
    continue
  fi

  echo "Position: $n"
done
