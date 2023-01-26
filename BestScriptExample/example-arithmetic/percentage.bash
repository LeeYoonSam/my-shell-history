#!/bin/bash

# Take the total number of students from the user
read -p 'Total number of students: ' total_std

# Take the total number of passed students from the user
read -p 'Total number of passed students: ' passed_std

# Calculate the percentage of passed students
printf "The percentage of passed students: %.2f%%\n" "$((10**3 * 100 * $passed_std/$total_std))e-3"