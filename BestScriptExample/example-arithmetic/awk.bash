#!/bin/bash

# Initialize the dividend value
n1=90
# Initialize the divisor value
n2=43

# Print the output without formating
awk "BEGIN {print $n1/$n2}"

# Print the output with formatting
awk "BEGIN {printf \"%.2f\n\", $n1/$n2}"
