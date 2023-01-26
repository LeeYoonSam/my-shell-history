#!/bin/bash

# Dividing 55 by 3 bc only
echo "55/3" | bc

# Dividing 55 by 3 bc and -l option
echo "55/3" | bc -l

# Dividing 55 by 3 with bc and scale value
echo "scale=2; 55/3" | bc