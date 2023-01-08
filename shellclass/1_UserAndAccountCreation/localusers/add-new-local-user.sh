#!/bin/bash

# Make sure the script is being executed with superuser privileges.
ROOT_USER=0
if [[ "${UID}" -ne $ROOT_USER ]]
then
  echo 'Please run with sudo or as root.'
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
if [[ "${#}" -lt 1 ]]
then
  echo 'Create an account on the local system with the name of USER_NAME and a comments field of COMMENT.'
  exit 1
fi

# The first parameter is the user name.
USER_NAME=${1}

# The rest of the parameters are for the account comments.
shift
COMMENT="${@}"

# Generate a password.
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The account coulud not be created.'
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set.'
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo 
echo 'username:'
echo "${USER_NAME}"
echo 
echo 'password:'
echo "${PASSWORD}"
echo 
echo 'hostname:'
echo "${HOSTNAME}"
exit 0
