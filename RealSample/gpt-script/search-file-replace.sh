#!/bin/bash

# Prompt the user for the directory to search and the search term
read -rp "Enter the directory to search: " directory
read -rp "Enter the search term: " search_term

# Prompt the user to choose whether to search by file name or content
echo "Search by: "
echo "1. File name"
echo "2. File content"
read -rp "Enter your choise [1-2]: " search_type

# Use grep to search for files based on the user's choice
case $search_type in
    1)
        # Search for files with the search term in the file name
        echo "Searching for files with '$search_term' in the file name..."
        grep -Ril "$search_term" "$directory"
        ;;
    2)
        # Search for files with the search term in the file content
        echo "Searching for files with '$search_term' in the file content..."
        grep -Ril "$search_term" "$directory" --exclude-dir={.git,.svn} > search-file-replace-test/temp.txt
        ;;
    *)
        echo "Invalid choice, exiting."
        exit 1
        ;;    
esac

# Prompt the user to choose whether to replace the search term with a new value
echo "Do you want to replace the search term?"
echo "1. Yes"
echo "2. No"
read -rp "Enter your choice [1-2]: " replace_choice

# Use sed to replace the search term in files
if [ "$replace_choice" -eq 1 ]; then
    read -rp "Enter the nwe value: " new_value
    sed -i "s/$search_term/$new_value/g" "$(grep -Ril "$search_term" "$directory")"
    echo "Search term replaced with '$new_value' in matching files."
fi

# Output the total number of files found
num_files=$(grep -Ril "$search_term" "$directory" | wc -l)
echo "Found ${num_files} file(s) with '$search_term'."