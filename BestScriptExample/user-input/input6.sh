#!/bin/bash

echo 'Enter your phone number(Maximum 15 characters): '

# Take input of a maximum 15 characters long
read -n 15 phone

# Add a newline
echo

# Print the input value
echo "Your phone number is $phone"