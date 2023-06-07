#!/bin/bash

# Check if log file path is provided as an argument
if [[ -z "$1" ]]; then
    echo "Please provide a log file path"
    exit 1
fi

# Check if the specified path is a valid file
if [[ ! -f "$1" ]]; then
    echo "Invalid log file path: $1"
    exit 1
fi

log_file="$1"

# Function to sesarch for events/patterns in the log file
search_log_file() {
    local pattern="$1"
    local count=0

    # Perform case-insensitive search and count occurrences
    count=$(grep -i -c "$pattern" "$log_file")

    echo "$count"
}

# Main script logic
echo "Log File Analyzer"
echo "================="

read -rp "Enter the event/pattern to search: " search_pattern
read -rp "Enter the number of top occurrences to display: " num_top_occurrences

echo "Analyzing log file: $log_file"
echo "Searching for: $search_pattern"

total_occurrences=$(search_log_file "$search_pattern")
echo "Total occurrences: $total_occurrences"

echo "Top $num_top_occurrences occurrences:"

grep -i -o "$search_pattern" "$log_file" | sort | uniq -c | sort -rn | head -n "$num_top_occurrences"