#!/bin/bash

# Set the filename for the contact list
file=contacts.txt

# Display the main menu
function menu {
    clear
    echo "Simple Contact List"
    echo "-------------------"
    echo "1. Add a contact"
    echo "2. Delete a contact"
    echo "3. List all contacts"
    echo "4. Quit"
    echo
}

# Add a contact to the contact list
function add {
    echo "Enter name: "
    read -r name

    echo "Enter phone number: "
    read -r number

    echo "$name:$number" >> "$file"
    echo "Contact added successfully"
    echo "Press enter to continue"
    read -r
}

# Delete a contact from the contact list
function delete {
    echo "Enter name to delete: "
    read -r name

    # Use grep to search for the line containing the name
    grep -v "^$name:" "$file" > "$file.temp"

    # 개행수를 확인해서 현재 연락처 리스트와 비교
    if [ "$(wc -l < "$file.temp")" -eq "$(wc -l < "$file")" ]; then
        echo "Contact not found"
    else
        # Replace the original file with the temporary file
        mv "$file.temp" "$file"
        echo "Contact deleted successfully"
    fi
    echo "Press enter to continue"
    read -r
}

# List all contacts in the contact list
function list {
    awk -F: '{ printf "%-20s %s\n", $1, $2 }' "$file"
    echo "Press enter to continue"
    read -r
}

# Main program loop
while true; do
    menu
    read -rp "Enter your choice [1-4]: " choice
    case $choice in
        1) add;;
        2) delete;;
        3) list;;
        4) exit;;
        *) echo "Invalid choice";;
    esac
done