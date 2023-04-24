#!/bin/bash

# Prompt the user for the file name to search and the search term
read -rp "Enter the file name to search: " file_name
read -rp "Enter the search term: " search_term

# Use grep to search for the search term in the file
if grep -q "$search_term" "$file_name"; then
    echo "Found '$search_term' in $file_name"
else
    echo "Could not find '$search_term' in $file_name"
fi