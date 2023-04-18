#!/bin/bash

# Ask user for directory path and keyword
read -rp "Enter directory path: " dir_path
read -rp "Enter keyword to search for: " keyword

# Search for keyword in all text files in directory
grep -r -n "$keyword" "$dir_path"/*.json
while read -r line; do
    # Extract filename, line number, and matching line
    filename=$(echo "$line" | cut -d':' -f1)
    line_num=$(echo "$line" | cut -d':' -f2)
    match=$(echo "$line" | cut -d':' -f3)

    # Print filename, line number, and matching line
    printf "%s:%s:%s\n" "$filename" "$line_num" "$match"
done

exit 0