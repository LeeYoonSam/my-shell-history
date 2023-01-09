#!/bin/bash

echo 'Enter five numeric values for the array with space: '

# Read values for the array
read -a MyArr

# Print all array values
echo ${MyArr[@]}

# Print the first value of array
echo ${MyArr[0]}

# Print the first two values of the array
echo ${MyArr[@]:0:2}

# Print the last vale of the array
echo ${MyArr[4]}