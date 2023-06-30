#!/bin/bash

# Configuration - Modifiy as needed
log_files=("$@")
alert_pattern="ERROR"
alert_command="echo Alert: Error found in log file!"
alert_log="alert_log.txt"

# Fuction to monitor log files and generate alerts
monitor_logs() {
    # Tail the log files in real-time
    tail -F "${log_files[@]}" | while read -r line; do
        # Check if the line matches the alert pattern
        if [[ $line =~ $alert_pattern ]]; then
            # Execute the alert command
            eval "$alert_command"

            # Log the alert
            echo "$(date '+%Y-%m-%d %H:%M:%S') - $line" >> "$alert_log"
        fi
    done
}

# Main script logic
echo "Log Monitoring and Alerting"
echo "==========================="

# Start monitoring the log files
monitor_logs