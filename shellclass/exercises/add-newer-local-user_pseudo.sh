#!/bin/bash
#
# This script creates a new user on the local system.
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.

# If the user doesn't supply at least one argument, then give them help.

# The first parameter is the user name

# The rest of the parameters are for the account comments.
# Generate a password.

# Create the user with the password.

# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.

# Set the password.

# Check to see if the passwd command succeeded.

# Force password change on first login.

# Display the username, password, and the host where the user was created.
