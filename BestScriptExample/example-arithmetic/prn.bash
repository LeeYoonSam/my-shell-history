#!/bin/bash
# Take the dividend value from the user
read -p "Enter the dividend value: " n1
# Take the divisor value from the user
read -p "Enter the divisor value: " n2

# Find the division using `echo` and `bc`
echo "scale=2; $n1/$n2"|bc

# Find the division using `printf`
printf "%.2f\n" "$((10**2 * $n1/$n2))e-2"