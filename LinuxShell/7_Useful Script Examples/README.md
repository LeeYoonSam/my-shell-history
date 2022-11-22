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
> 아무것도 하지 말라는 명령

아무것도 하지 않는 명령을 사용하는 것이 때때로 유용합니다(예: Python의 `pass` 명령). 

예를 들어, 이러한 명령은 명확한 `if` 문을 작성하는 데 유용할 수 있습니다. 

다음은 콜론 명령을 사용하여 이 결과를 얻는 방법을 보여줍니다.

```sh
answer="no"
if [ "$answer" = "no" ]; then
    # don't do anything
    :
fi
```
- `if` 블록 내에서만 주석을 달면 구문 오류가 발생하므로 위의 논리가 필요합니다.

## Control echo of script commands as script runs
> 스크립트가 실행될 때 스크립트 명령의 `echo` 제어

대부분의 경우 스크립트에서 실행된 명령은 종종 이해하기 어려운 과도하고 혼란스러운 출력을 생성하기 때문에 콘솔에 에코되지 않아야 합니다.
그러나 중복 `echo` 명령을 사용하지 않고 사용자에게 긴 명령을 표시하거나 문제 해결을 위해 실행되는 명령을 에코(추적)하는 것이 도움이 되는 경우가 있을 수 있습니다.

### Turn on echo/trace for entire script
> 전체 스크립트에 대해 echo/trace 를 켭니다.

전체 스크립트에 대해 에코/추적을 켜려면 다음과 같이 shebang 행에 -x 옵션을 추가할 수 있습니다.

```sh
#!/bin/sh -x
```
이렇게 하면 스크립트의 모든 명령이 실행되기 전에 콘솔에 인쇄됩니다. 일반적으로 문제 해결이나 개발 중에만 사용됩니다.

### Run a script with echo/trace turned on
> echo/trace 를 켠 상태에서 스크립트 실행

다음과 같이 스크립트를 실행하여 유사한 효과를 얻을 수 있습니다. <br>
-x 옵션은 최상위 스크립트에서만 유효하며 호출된 모든 스크립트에는 자체 설정이 있습니다.
```sh
$ sh -x some-script
```

### Control echo/trace line by line within a script
> 스크립트 내에서 한 줄씩 echo/trace 제어

예를 들어 사용자가 실행 중인 항목을 이해하는 데 도움이 되도록 스크립트의 특정 줄에 대해 echo/trace을 켜는 것도 유용할 수 있습니다. 

다음은 한 명령에 대해 에코를 설정한 다음 해제하는 방법을 보여줍니다.
```sh
# Some script ...
# The following starts to echo commands as the are run
set -x
somecommands..
{ set +x; } 2> /dev/null
```
`set -x`는 echo/trace를 켭니다. `{ set +x; } 2> /dev/null`은 echo/trace를 끄고 출력을 특수 `/dev/null` 출력 장치로 흡수합니다.

## Determine the folder where a script exists
## Determine the operating system
## Echo colored text to console
## Ensure that script runs on Linux and Windows
## Log Messages and Program Output
## Parsing command line options
### Parsing command line options with built-in getopts
### Parsing command line options with getopt command
## Set Terminal Title