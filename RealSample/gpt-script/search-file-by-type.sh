#!/bin/bash

# Prompt the user for the directory to search and the search term
read -rp "Enter the directory to search: " directory
read -rp "Enter the search term: " search_term

# Prompt the user to choose whether to search by file name or content
echo "Search by: "
echo "1. File name"
echo "2. File content"
read -rp "Enter your choice [1-2]: " search_type

# Use grep to search for filese based on the user's choice
case $search_type in
    1)
        # Search for files with the search term in the file name
        echo "Searching for files with '$search_term' in the file name..."
        grep -Ril "$search_term" "$directory"
        ;;
    2)
        # Search for files with the search term in the file content
        echo "Searching for files with '$search_term' in the file content..."
        grep -Ril "$search_term" "$directory" --exclude-dir={.git,.svn} >/dev/null
        ;;
    *)
        echo "Invalid choice, exiting." >&2
        exit 1
        ;;
esac

# Output the total number of files found
num_files=$(grep -Ril "$search_term" "$directory" | wc -l)
echo "Found $num_files file(s) with '$search_term'."