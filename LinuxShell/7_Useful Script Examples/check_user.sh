#!/bin/sh

# Get the location where this script is located since it may have been run from any folder
scriptFolder=$(cd $(dirname "$0") && pwd)
echo $scriptFolder
# Script name is used in some output, use the actual script in case file was renamed
scriptNameFromCommandLine=$(basename $0)
echo $scriptNameFromCommandLine

# Make sure that the script is being run as as root (or sudo)
# - pass the script name (file only) as the first function argument
# - Running 'sudo whomami' shows "root"
checkSudo() {
    local user scriptName
    scriptName = $1
    user=`whoami`
    if [ "$user" != "root" ]; then
        echo ""
        echo "You are not running as root."
        echo "Run with:          sudo $scriptName"
        echo "or, if necessary:  sudo ./$scriptName"
        echo ""
        exit 1
    else
        echo ""
        echo "You are running as root or sudo.  There should be no permissions issues."
        echo ""
    fi
}

# Call the function to make sure running as superuser
checkSudo $scriptNameFromCommandLine