#!/bin/bash

# A list of servers, one per line.
SERVER_LIST='/vagrant/servers'

# Options for the ssh command.
SSH_OPTIONS='-o ConnectTimeout=2'

usage() {
    # Display the usage and exit.
	echo "Usage: ${0} [-nsv] [-f FILE] COMMAND" >&2
	echo "Executes COMMAND as a single command on every server." >&2
	echo "	-f FILE Use FILE for the list of servers. Default: ${SERVER_LIST}." >&2
	echo "	-n		Dry run mode. Display the COMMAND that would have been executed and exit." >&2
	echo "	-s		Execute the COMMAND using sudo on the remote server." >&2
	echo "	-v		Verbose mode. Displays the server name before executing COMMAND." >&2
    exit 1
}

# Make sure the script is not being executed with superuser privileges.


# Parse the options.


# Remove the options while leaving the remaining arguments.


# If the user doesn't supply at least one argument, give them help.


# Anything that remains on the command line is to be treated as a single command.


# Make sure the SERVER_LIST file exists.


# Expect the best, prepare for the worst.
EXIT_STATUS='0'

# Loop through the SERVER_LIST
while 
do
    # If it's a verbose
	if [[ "${VERBOSE}" = 'true' ]]; then
		echo "${SERVER}"
	fi

    # Create a SSH_COMMAND
	

	# If it's a dry run, don't execute anything, just echo it.
	if [[ "${DRY_RUN}" = 'true' ]]; then
		
	else
		

		# Capture any non-zero exit status from the SSH_COMMAND and report to the user.
		
	fi
done

exit ${EXIT_STATUS}