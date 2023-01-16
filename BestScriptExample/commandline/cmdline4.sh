#!/bin/bash

# Reading arguments with getopts options
while getopts 'h:u:p' OPTION; do
    case "$OPTION" in
        h)
            # Print hostname
            echo "The host name is $OPTARG" ;;
        u)
            # Print username
            echo "The username is $OPTARG" ;;
        p)
            # Print password
            echo "The password is $OPTARG" ;;
        *)
            # Print helping message for providing wrong options
            echo "Usage: $0 [-h value] [-u value] [-p value]" >&2
            # Terminate from the script
            exit 1 ;;
    esac
done

# Remove all options passed by getopts options
shift "$(($OPTIND -1))"

# Reading first normal arguments
if [ ! -z $1 ]; then
    echo "The first table name is $1"
else
    echo "No normal argument is given."
    exit 1
fi

# Reading second normal arguments
if [ ! -z $2 ]; then
    echo "The second table name is $2"
fi

# Reading third normal arguments
if [ ! -z $3 ]; then
    echo "The third table name is $3"
fi