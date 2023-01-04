#!/bin/bash

# Creating an infinite loop

n=1

while :
do
  printf "The current value of n=$n\n"
  if [ $n == 3 ]
  then
    echo "good"
  elif [ $n == 5 ]
  then
    echo "bad"
  elif [ $n == 7 ]
  then
    echo "ugly"
  elif [ $n == 10 ]
  then
    exit 0
  fi
 
  (( n++ ))

done

read filename
while read line
do
  echo $line >> $filename
done
