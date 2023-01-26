#!/bin/bash

# Take the dividend value from the user
read -p "Enter the dividend value: " n1
# Take the divisor value from the user
read -p "Enter the divisor value: " n2

# Find the division using `printf`, `echo` and `bc`
printf "%.2f\n" `echo $n1/$n2|bc -l`