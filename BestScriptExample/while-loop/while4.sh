#!/bin/bash

# Read the command-line argument with options

while getopts n:a:e: OPT
do
  case "${OPT}"
  in
    n) name=${OPTARG};;
    a) address=${OPTARG};;
    e) email=${OPTARG};;
    *) echo "Invalid option"
       exit 1;;
  esac
done

printf "Name:$name\nAddress:$address\nEmail:$email\n"

# 실행 예: ./while4.sh -n albert -a guri -e albert@gmail.com