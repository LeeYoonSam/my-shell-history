#!/bin/bash

read -rp "Enter website URL: " url
read -rp "Enter HTML tags (separated by commas): " tags

# Retrieve website's HTML code
html=$(curl -s "$url")

# Search for specified HTML tags and save results to file
for tag in $(echo "$tags" | tr ',' ' '); do
    echo "$html" | grep "<$tag" > "$tag.txt"
done

echo "Scraping complete. Results saved to file."