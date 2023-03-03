#!/bin/bash
#
# This script disables, deletes, and/or archives users on the local system.
#


  # Display the usage and exit.

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
