#!/bin/bash
#
# This script disables, deletes, and/or archives users on the local system.

usage() {
    # Display the usage and exit.
    echo "Usage: ${0} [-dra] USER [USERN]..." >&2
    echo 'Disable a local Linux account.' >&2
    echo '  -d  Deletes accounts instead of disabling them.' >&2
    echo '  -r  Removes the home directory associated with the account(s).' >&2
    echo '  -a  Creates an archive of the home directory associated with the account(s).' >&2
    exit 1
}

# Make sure the script is being executed with superuser privileges.

# Parse the options.

# Remove the options while leaving the remaining arguments.

# If the user doesn't supply at least one argument, give them help.

# Loop through all the usernames supplied as arguments.
for USERNAME in "${@}"
do
    echo "Processing user: ${USERNAME}"

    # Make sure the UID of the account is at least 1000.

    # Create an archive if requested to do so.

        # Delete the user.

        # Check to see if the userdel command succeeded.
        # We don't want to tell the user that an account was deleted when it hasn't been.
    
    
        # Check to see if the chage command succeeded.
        # We don't want to tell the user that an account was disabled when it hasn't been.
    
done

exit 0
