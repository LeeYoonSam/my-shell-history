#!/bin/bash

# Function to synchronize files and directories
sync_files() {
    # Perform one-way synchronization from source to destination
    rsync -av --delete "$source_directory/" "$destination_directory/" 

    # Perform two-way synchronization (uncomment below lines) - Use with caution!
    # rsync -av --delete "$source_directory/" "$destination_directory/"
    # rsync -av --delete "$destination_directory/" "$source_directory/"
}

# Main script logic
echo "File Synchronization"
echo "===================="

if [ $# -lt 2 ]; then
    echo "Please input source directory and destination directory."
    echo "Usage: $0 [source_directory] [destination_directory]" >&2
    exit 1
fi

source_directory=$1
destination_directory=$2

# Check if source directory exists
if [ ! -d "$source_directory" ]; then
    echo "Source directory not found." >&2
    exit 1
fi

# Check if destination directory exists
if [ ! -d "$destination_directory" ]; then
    echo "Destination directory not found." >&2
    exit 1
fi

#Start file synchronization
sync_files