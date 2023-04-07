#!/bin/bash

# Prompt user to enter directory path and archive name
read -rp "Enter directory path: " dir_path

# Check if the directory exists
if [ ! -d "$dir_path" ]; then
    echo "Directory not found!"
    exit 1
fi

# Get the name for the archive file
read -rp "Enter archive name: " archive_name

function compressing_tar() {
    # Compress files in directory into archive
    if tar "$format_option" "$archive_name.$1" -C "$dir_path" .; then
        echo "Files compressed successfully"
    else
        echo "Error compressing files"
    fi
}

function compressing_zip() {
    # Compress files in directory into archive
    # format_option 을  "" 로  감싸면 작동하지 않음
    zip $format_option "$archive_name.$1" "$dir_path"
    echo "Files compressed successfully"
}

# Prompt user to choose archive format
echo "Choose archive format:"
select format in "tar" "tar.gz" "tar.xz" "tar.bz2" "zip"
do
    case $format in
        tar) 
            format_option="cvf"
            compressing_tar $format
            break;;
        tar.gz) 
            format_option="czvf"
            compressing_tar $format
            break;;
        tar.xz) 
            format_option="cJvf"
            compressing_tar $format
            break;;
        tar.bz2) 
            format_option="cjvf"
            compressing_tar $format
            break;;
        zip) 
            format_option="-r -j"
            compressing_zip $format
            break;;
        *) 
            echo "Invalid option"
            exit 1;;
    esac
done