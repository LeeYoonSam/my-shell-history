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
> 스크립트가 있는 폴더 확인

스크립트는 종종 입력 및 출력 파일의 위치를 ​​알아야 합니다. 예를 들어 현재 폴더에 이름을 지정하거나, 다른 폴더에 대한 절대 또는 상대 경로를 사용하거나, `PATH` 환경 변수에서 찾는 등 스크립트가 실행되는 방식으로 인해 복잡해질 수 있습니다.

한 가지 옵션은 스크립트 위치와 같은 특정 폴더에서 스크립트를 실행하도록 요구하는 것입니다. 그러나 이것은 유연성을 감소시킵니다. 모든 폴더에서 스크립트 실행을 허용하려면 입력 및 출력이 해당 위치에 상대적으로 지정될 수 있도록 스크립트의 절대 위치를 결정해야 합니다. 다음은 실행 중인 스크립트의 절대 경로를 결정합니다.

```sh
# Get the location where this script is located since it may have been run from any folder
scriptFolder=$(cd $(dirname "$0") && pwd)
# Also determine the script name, for example for usage and version.
# - this is useful to prevent issues if the script name has been changed by renaming the file
scriptName=$(basename $scriptFolder)
```

$0 명령 인수에는 파일 또는 경로일 수 있는 스크립트 이름이 포함됩니다. 따라서 위의 논리는 스크립트가 있는 디렉토리로 변경됩니다. &&는 첫 번째 명령(이 경우 pwd 명령) 다음에 두 번째 명령을 실행하도록 나타냅니다. 출력은 다른 논리에서 사용할 수 있는 scriptFolder 변수에 할당됩니다. 심볼릭 링크가 관련되어 있고 웹에서 추가 정보를 사용할 수 있는 경우 이 방법이 작동하지 않을 수 있습니다.

Examples:
- [Open Water Foundation git-check-util](https://github.com/OpenWaterFoundation/owf-util-git/blob/main/build-util/git-check-util.sh)

```sh
#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL
#
# git-check-util - check the Git utilities repositories for status
# - this script calls the general git utilities script

# Get the location where this script is located since it may have been run from any folder
scriptFolder=`cd $(dirname "$0") && pwd`

# Git utilities folder is relative to the user's files in a standard development files location
# - determine based on location relative to the script folder
# Specific repository folder for this repository
repoHome=`dirname ${scriptFolder}`
# Want the parent folder to the specific Git repository folder
gitReposHome=`dirname ${repoHome}`

# Main repository
mainRepo="owf-util-git"

# Now run the general script using full path
${scriptFolder}/git-util/git-check.sh -m "${mainRepo}" -g "${gitReposHome}" $@
```

## Determine the operating system
> 운영 체제 결정

다른 Linux 유사 운영 체제를 지원하기 위해 스크립트에 다른 논리가 필요한 경우가 있습니다.

예를 들어 파일은 서로 다른 운영 체제의 서로 다른 위치에 존재할 수 있습니다. 다음 `sh` 함수는 운영 체제를 나타내는 변수를 설정하며 이 변수는 `if` 문에서 로직을 제어하는 ​​데 사용할 수 있습니다.

```sh
# Determine the operating system that is running the script
# - mainly care whether Cygwin
checkOperatingSystem()
{
    operatingSystem="unknown"
    os=`uname | tr [a-z] [A-Z]`
    case "${os}" in
        CYGWIN*)
            operatingSystem="cygwin"
            ;;
        LINUX*)
            operatingSystem="linux"
            ;;
        MINGW*)
            operatingSystem="mingw"
            ;;
    esac
    echo "operatingSystem=$operatingSystem (used to check for Cygwin and filemode compatibility)"
}
```

Examples:
- [Open Water Foundation git-check](https://github.com/OpenWaterFoundation/owf-app-geoprocessor-python/blob/master/build-util/git-util/git-check.sh)

## Echo colored text to console
> 콘솔에 에코 컬러 텍스트

예를 들어 경고 또는 오류 메시지를 강조 표시하기 위해 컬러 텍스트를 콘솔에 인쇄하는 것이 유용할 수 있습니다. echo 명령을 사용하여 특수 문자를 인쇄할 수 있습니다.

- [How to change RGB colors in Git Bash for windows](https://stackoverflow.com/questions/21243172/how-to-change-rgb-colors-in-git-bash-for-windows)
- [Unix escape sequences](https://en.wikipedia.org/wiki/ANSI_escape_code#Unix-like_systems)
- [Yellow "33" in Linux can show as brown](https://unix.stackexchange.com/questions/192660/yellow-appears-as-brown-in-konsole)

특수 문자를 인쇄하려면 echo -e를 사용해야 합니다. 

쉘에 있는 내장 echo 명령은 -e 옵션을 지원하지 않을 수 있으며 시스템 프로그램과 같은 다른 echo 프로그램을 실행해야 할 수도 있습니다.

따라서 먼저 사용할 echo 명령을 결정합니다.

```sh
# Determine which echo to use, needs to support -e to output colored text
# - normally built-in shell echo is OK, but on Debian Linux dash is used, and it does not support -e
echo2='echo -e'
testEcho=`echo -e test`
if [ "${testEcho}" = '-e test' ]; then
    # The -e option did not work as intended.
    # -using the normal /bin/echo should work
    # -printf is also an option
    echo2='/bin/echo -e'
    # The following does not seem to work
    #echo2='printf'
fi
```

색상을 제어하는 ​​문자는 echo 문에서 이스케이프 문자로 출력됩니다. 

다음과 같이 색상을 변수로 할당하는 것이 유용합니다.

```sh
# Strings to change colors on output, to make it easier to indicate when actions are needed
# - Set the background to black to eensure that white background window will clearly show colors contrasting on black.
# - Tried to use RGB but could not get it to work - for now live with "yellow" as it is
actionColor='\e[0;40;33m' # user needs to do something, 40=background black, 33=yellow
actionWarnColor='\e[0;40;31m' # serious issue, 40=background black, 31=red
okColor='\e[0;40;32m' # status is good, 40=background black, 32=green
colorEnd='\e[0m' # To switch back to default color
```

마지막으로 echo 문에서 특수 문자를 사용합니다. ${echo2}는 올바른 echo 명령을 실행하는 데 사용됩니다.

```sh
${echo2} "Number of up-to-date repositories: ${okColor}${upToDateRepoCount}${colorEnd}"
```

Examples:
-[Open Water Foundation git-check](https://github.com/OpenWaterFoundation/owf-app-geoprocessor-python/blob/master/build-util/git-util/git-check.sh)


## Ensure that script runs on Linux and Windows
## Log Messages and Program Output
## Parsing command line options
### Parsing command line options with built-in getopts
### Parsing command line options with getopt command
## Set Terminal Title