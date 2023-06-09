#!/bin/bash

# Function to display menu options
display_menu() {
    echo "File Management Script"
    echo "======================"
    echo "1. Copy a file"
    echo "2. Move a file"
    echo "3. Rename a file"
    echo "4. Delete a file"
    echo "5. Search for file"
    echo "6. Display file information"
    echo "7. Organize files by extension"
    echo "8. Exit"
    echo 
}

create_new_folder() {
    echo "Create new $1 folder."
    mkdir -p "$1" > /dev/null 2>&1
}

# Function to copy a file
copy_file() {
    echo "Enter the path of the file to be copied:"
    read -r source_file

    echo "Enter the destination path:"
    read -r destination

    if [[ ! -d "$destination" ]]; then
        create_new_folder "$destination"
    fi

    cp "$source_file" "$destination"
    echo "File copied successfully!"
}

# Function to move a file
move_file() {
    echo "Enter the path of the file to be moved:"
    read -r source_file

    echo "Enter the destination path:"
    read -r destination

    if [[ ! -d "$destination" ]]; then
        create_new_folder "$destination"
    fi

    mv "$source_file" "$destination"
    echo "File moved successfully!"
}

# Function to rename a file
rename_file() {
    echo "Enter the path of the file to be renamed:"
    read -r source_file

    echo "Enter the new name:"
    read -r new_name

    mv "$source_file" "$(dirname "$source_file")/$new_name"
    echo "File renamed successfully!"
}

# Function to delete a file
delete_file() {
    echo "Enter the path of the file to be deleted:"
    read -r file_path

    rm "$file_path"
    echo "File deleted successfully!"
}

# Function to search for files
search_files() {
    echo "Enter the directory path to search in:"
    read -r directory

    echo "Enter the search keywords:"
    read -r keyword

    echo "Seasrch results:"
    find "$directory" -type f -name "*$keyword*"
}

# Function to display file information
display_file_info() {
    echo "Enter the path of the file:"
    read -r file_path

    echo "File information:"
    ls -l "$file_path"
}

# Function to organize files by extension
organize_files_by_extension() {
    echo "Enter the directory path to organize:"
    read -r directory

    echo "Organizing files..."
    find "$directory" -type f | while read -r file; do
        extension="${file##*.}"
        mkdir -p "$directory/$extension"
        mv "$file" "$directory/$extension"
    done

    echo "Files organized by extension!"
}

# Main script logic
while true; do
    display_menu
    echo "Enter your choice:"
    read -r choice

    case $choice in
        1) copy_file ;;
        2) move_file ;;
        3) rename_file ;;
        4) delete_file ;;
        5) search_files ;;
        6) display_file_info ;;
        7) organize_files_by_extension ;;
        8) exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac

    echo
done