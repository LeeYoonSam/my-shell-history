#!/bin/bash

if [[ "${#}" -lt 1 ]]; then
    echo "Usage: $0 [Website URL]" >&2
    exit 1
fi

url="$1"
expiration_threshold=30

http_status=$(curl -sL -w "%{http_code}" "${url}" -o /dev/null)

if [[ "${http_status}" -eq 200 ]]; then
    echo "HTTP status: OK"
else
    echo "HTTP status: ERROR"
    exit 1
fi

broken_links=$(wget -r -l O "${url}" 2>&1 | grep -c " 404 ")

if [[ "${broken_links}" -gt 0 ]]; then
    echo "Broken links found: ${broken_links}"
else
    echo "No broken links found"
fi

expiration_date=$(echo | openssl s_client -servername "${url}" -connect "${url}":443 2>/dev/null | openssl x509 -noout -enddate | grep "notAfter" | cut -d= -f 2)

expiration_epoch=$(date -v "${expiration_date}" +%s)
now_epoch=$(date +%s)
days_to_expiry=$(((expiration_epoch - now_epoch) / 86400))

if [[ "${days_to_expiry}" -gt "${expiration_threshold}" ]]; then
    echo "SSL certificate: OK"
else
    echo "SSL certificate: Expiring soon"
fi