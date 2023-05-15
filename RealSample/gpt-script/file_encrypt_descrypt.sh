#!/bin/bash

function usage() 
{
    echo "Usage: $0 [file_path] [password]"
    exit 1
}

if [[ $# -ne 2 ]]; then
    usage
fi

file_path=$1
password=$2

if [[ ! -f $file_path ]]; then
    echo "Error: file does not exist"
    exit 1
fi

if [[ -z $password ]]; then
    echo "Error: password is empty"
    exit 1
fi
    
read -rp "Do you want to encrypt or decrypt the file? (e/d): " choice

if [[ $choice == "e" ]]; then
    openssl aes-256-cbc -a -salt -in "$file_path" -out "$file_path.enc" -pass "pass:$password"
    echo "File successfully encrypted"
elif [[ $choice == "d" ]]; then
    openssl aes-256-cbc -d -a -salt -in "$file_path" -out "$file_path.dec" -pass "pass:$password"
else
    usage
fi