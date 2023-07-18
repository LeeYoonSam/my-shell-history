#!/bin/bash

# Log directory path
log_directory="/path/to/logs"

# Maximum log file size in kilobytes
max_file_size=1024

# Retention period in days
retention_period=7

# Compression method for old log files
compression_method="gzip"

# Function to rotate log files
rotate_logs() {
    echo "Log Rotation and Cleanup"
    echo "========================"

    # Check if log directory exists
    if [[ ! -d "$log_directory" ]]; then
        echo "Log directory does not exist: $log_directory"
        exit 1
    fi

    # Rotate log files based on size and retention period
    find "$log_directory" -type f -name "*.log" -size +${max_file_size}k -mtime +${retention_period} -print0 |
    while IFS= read -r -d '' file; do
        echo "Rotating log file: $file"
        mv "$file" "${file}.old"
    done

    # Compress old log files
    find "$log_directory" -type f -name "*.old" -print0 |
    while IFS= read -r -d '' file; do
        echo "Compressing log file: $file"
        "$compression_method" "$file"
    done

    # Remove old compressed log files
    find "$log_directory" -type f -name "*.old.gz" -delete

    echo "Log Rotation and Cleanup Completed!"
}

# Main script logic
rotate_logs