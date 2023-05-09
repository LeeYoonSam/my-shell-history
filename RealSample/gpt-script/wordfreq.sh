#!/bin/bash

# Check if input file is provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Read the input file and convert to lowercase
text=$(< "$1" tr '[:upper:]' '[:lower:]')

# Remove punctutation marks and special characters
text=$(echo "$text" | tr -cd '[:alnum:][:space:]')

# Split text into words and count frequency of each word
word_count=$(echo "$text" | tr ' ' '\n' | sort | uniq -c)

# Sort words based on frequency in descending order
sorted_words=$(echo "$word_count" | sort -nr)

# Display the word frequency count
echo "$sorted_words"