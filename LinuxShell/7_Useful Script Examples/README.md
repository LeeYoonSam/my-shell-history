# [7. Useful Script Examples](https://learn.openwaterfoundation.org/owf-learn-linux-shell/useful-scripts/useful-scripts/)

> 이 페이지는 스크립트에서 사용할 수 있는 유용한 셸 스크립트 또는 코드 덩어리의 예를 제공합니다. 이러한 예의 대부분은 sh에 대한 것입니다. 그러나 표시된 예제는 대부분의 경우 bash 및 기타 셸에서도 작동해야 합니다(그렇지 않은 경우 동등한 구문을 확인할 수 있음).

- [Check user running script](#check-user-running-script)
- [Command to do nothing](#command-to-do-nothing)
- [Control echo of script commands as script runs](#control-echo-of-script-commands-as-script-runs)
- [Determine the folder where a script exists](#determine-the-folder-where-a-script-exists)
- [Determine the operating system](#determine-the-operating-system)
- [Echo colored text to console](#echo-colored-text-to-console)
- [Ensure that script runs on Linux and Windows](#ensure-that-script-runs-on-linux-and-windows)
- [Log Messages and Program Output](#log-messages-and-program-output)
- [Parsing command line options](#parsing-command-line-options)
    - [Parsing command line options with built-in getopts](#parsing-command-line-options-with-built-in-getopts)
    - [Parsing command line options with getopt command](#parsing-command-line-options-with-getopt-command)
- [Set Terminal Title](#set-terminal-title)

---

## Check user running script
> 사용자 실행 스크립트 확인

어떤 사용자가 스크립트를 실행하고 있는지 확인해야 하는 경우가 있습니다. 예를 들어 사용자가 `수퍼유저`인지 여부를 확인합니다. 다음 함수 함수는 whoami Linux 명령을 사용하여 사용자가 `수퍼유저`로 실행 중인지 확인하고 그렇지 않은 경우 경고를 인쇄하고 종료합니다. 대부분의 경우 스크립트는 `sudo scriptname`으로 실행됩니다.

```sh
#!/bin/sh

# Get the location where this script is located since it may have been run from any folder
scriptFolder=$(cd $(dirname "$0") && pwd)
# Script name is used in some output, use the actual script in case file was renamed
scriptNameFromCommandLine=$(basename $0)

# Call the function to make sure running as superuser
checkSudo $scriptNameFromCommandLine

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
```


## Command to do nothing
## Control echo of script commands as script runs
## Determine the folder where a script exists
## Determine the operating system
## Echo colored text to console
## Ensure that script runs on Linux and Windows
## Log Messages and Program Output
## Parsing command line options
### Parsing command line options with built-in getopts
### Parsing command line options with getopt command
## Set Terminal Title