#!/bin/bash

# Using C-style while loop

n=5

while((n <= 50))
do
  echo $n
  ((n=n+10))
done
