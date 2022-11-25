#!/bin/sh

# Determine which echo to use, needs to support -e to output colored text
# - normally built-in shell echo is OK, but on Debian Linux dash is used, and it does not support -e
echo2='echo -e'
# testEcho=`echo -e test`
# if [ "${testEcho}" = '-e test' ]; then
#     # The -e option did not work as intended.
#     # -using the normal /bin/echo should work
#     # -printf is also an option
#     echo2='/bin/echo -e'
#     # The following does not seem to work
#     #echo2='printf'
# fi

# Strings to change colors on output, to make it easier to indicate when actions are needed
# - Set the background to black to eensure that white background window will clearly show colors contrasting on black.
# - Tried to use RGB but could not get it to work - for now live with "yellow" as it is
actionColor='\e[0;40;33m' # user needs to do something, 40=background black, 33=yellow
actionWarnColor='\e[0;40;31m' # serious issue, 40=background black, 31=red
okColor='\e[0;40;32m' # status is good, 40=background black, 32=green
colorEnd='\e[0m' # To switch back to default color
upToDateRepoCount='10'

${echo2} "Number of up-to-date repositories: ${okColor}${upToDateRepoCount}${colorEnd}"

# Done
exit 0