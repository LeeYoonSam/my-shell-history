#!/bin/bash

# Check if directory path is provided as an argument
if [[ -z "$1" ]]; then
    echo "Please provide a direcotry path."
    exit 1
fi

# Check if the specified path is a valid directory
if [[ ! -d "$1" ]]; then
    echo "Invalid directory path: $1"
    exit 1
fi

calculate_directory_size() {
    local dir_path="$1"
    local total_size=0

    for file in "$dir_path"/*; do
        if [[ -f "$file" ]]; then
            # Add the size of regular files
            total_size=$((total_size + $(stat -f %z "$file")))
        elif [[ -d "$file" ]]; then
            # Recursively calculate the size of subdirectories
            total_size=$((total_size + $(calculate_directory_size "$file")))
        fi
    done

    echo "$total_size"
}

# Main script logic
directory_path="$1"
total_directory_size=$(calculate_directory_size "$directory_path")

echo "Total size of the directory: $total_directory_size bytes"

echo "Subdirectory sizes:"
while IFS= read -r subdirectory; do
    size=$(calculate_directory_size "$subdirectory")
    echo "$size bytes - $subdirectory"
done < <(find "$directory_path" -type d -not -path "$directory_path" -print0 | xargs -0)