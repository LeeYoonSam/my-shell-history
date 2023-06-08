#!/bin/bash

# Configuration - Set the desired thresholds (modify as needed)
cpu_threshold=80           # CPU usage threshold in percentage
memory_threshold=90        # Memory usage threshold in percentage
disk_threshold=80          # Disk usage threshold in percentage

# Monitoring interval in seconds
interval=5

# Log file to store resource utilization data
log_file="resource_utilization.log"

# Function to display resource utilization information
display_utilization() {
    echo "Resource Utilization"
    echo "===================="
    echo "Cpu Usage: $(top -l 1 | awk '/CPU usage:/ {print $3}')%"
    getMemoryUsage
    echo "Disk Usage: $(df -H / | awk 'NR==2 {print $5}')"
    echo "Network Statistics:"
    echo "  $(ifconfig | awk '/^en/ {print $1}')"
    echo
}

getMemoryUsage() {
    memory_info=$(top -l 1 | awk '/PhysMem:/ {print $2}')
    used=$(echo "$memory_info" | awk -F'[BM]' '{print $1}')
    total=$(echo "$memory_info" | awk -F'[BM]' '{print $2}')
    percentage=$(echo "scale=2; $used / $total * 100" | bc)

    echo "Memory usage: $percentage%"
}

# Function to check and display alerts for resource thresholds
check_thresholds() {
    if [[ $(top -l 1 | awk '/CPU usage:/ {print int($3)}') -gt $cpu_threshold ]]; then
        echo "ALERT: High CPU usage detected!"
    fi

    if (( $(echo "$percentage > $memory_threshold" | bc -l) )); then
        echo "ALERT: High memory usage detected!"
    fi

    if [[ $(df -H / | awk 'NR==2 {print $5}' | tr -d "%") -gt $disk_threshold ]]; then
        echo "ALERT: High disk usage detected!"
    fi
}

# Function to log resource utilization data to a file
log_utilization() {
    echo "$(date "+%Y-%m-%d %H:%M:%S"),$(top -l 1 | awk '/CPU usage:/ {print int($3)}'),$used,$(df -h / | awk 'NR==2 {print $5}' | tr -d "%")" >> "$log_file"
}

# Main script logic
echo "System Resource Monitor"
echo "======================="

while true; do
    display_utilization
    check_thresholds
    log_utilization

    sleep "$interval"
done