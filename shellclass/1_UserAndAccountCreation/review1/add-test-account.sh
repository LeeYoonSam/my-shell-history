#!/bin/bash

# Add some accounts to test with
if [[ ${UID} -ne 0 ]]; then
	echo "Please run with sudo or as root." >&2
	exit 1
fi

echo "Usage: ${0} [COUNT]"
read -p "How many test account do you need? " count

while [[ "${count}" -gt 0 ]]
do
	tester=$(echo $RANDOM | base64 | sed 's/[^a-zA-Z0-9]//' | head -c 20)
	echo $tester
	useradd ${tester}
    echo 'pass123' | passwd --stdin ${tester}
	((count--))
done
