#!/bin/bash

# <Usage>
# ./organizing-files.sh
# Enter directory path: /users/ys/Downloads/organize-test
# Select organization option:
# 1. Organize by file type
# 2. Organize by file size
# 3. Organize by date modified
# Enter option number: 1
# Delete remaining files in original directory? (y/n)n
# Organization complete!

# Prompt user for directory path
read -rp "Enter directory path: " dir_path

# Move to directory
cd "$dir_path" || exit

# Display menu of organization options
echo "Select organization option:"
echo "1. Organize by file type"
echo "2. Organize by file size"
echo "3. Organize by date modified"

# Read user choice
read -rp "Enter option number: " option

# Perform organization based on user choice
case $option in
    1)
        # Organize by file type
        for f in *; do
            if [[ -f $f ]]; then
                extension="${f##*.}"
                mkdir -p "$extension"
                mv "$f" "$extension"
            fi
        done
        ;;
    2)
        # Organize by file size
        read -rp "Enter file size (in bytes): " file_size
        for f in *; do
            if [[ -f $f && $(stat -f %z "$f") -gt $file_size ]]; then
                large_files="large_files"
                mkdir -p "$large_files"
                mv "$f" "$large_files"
            fi
        done
        ;;
    3)
        # Organize by date modified
        read -rp "Enter number of days: " num_days
        for f in *; do
            if [[ -f $f && $(find "$f" -mtime -"$num_days" -print) ]]; then
                recent_files="recent_files"
                mkdir -p "$recent_files"
                mv "$f" "$recent_files"
            fi
        done
        ;;
    *)
        echo "Invalid option"
        ;;
esac

# Give user the option to delete remaining files in original directory
read -rp "Delete remaining files in original directory? (y/n)" delete_option
if [[ $delete_option == "y" ]]; then
    # ./*
    #   ./*를 사용하면 글로브가 ./-f로 확장되어 어떤 프로그램도 옵션으로 취급하지 않습니다.
    # -- *
    #   --는 관례상 옵션의 끝을 나타내며, 그 뒤의 것은 플래그처럼 취급되지 않습니다(일부 프로그램은 여전히 특수 대소문자(예: stdin)로 처리될 수 있음).
    rm -f ./*
fi

echo "Organization complete!"