#!/bin/bash

# Calcualte the mathematical expression
val1=$((10*5+15))
echo $val1

# Using post or pre increment/decrement operator
((val1++))
echo $val1
val2=41
((--val2))
echo $val2

# Using shorthand operator
(( val2 += 60 ))
echo $val2

# Dividing 40 by 6
(( val3 = 40/6 ))
echo $val3