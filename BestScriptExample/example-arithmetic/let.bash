#!/bin/bash

# Multiplying 9 by 8
let val1=9*8
echo $val1

# Dividing 8 by 3
let "val2 = 8 / 3"
echo $val2

# Subtracting 3 from 9
let val3=9-3
echo $val3

# Applying increment
let val4=7
let val4++
echo $val4

# Using argument value in arithmetic operation
let "val5=50+$1"
echo $val5