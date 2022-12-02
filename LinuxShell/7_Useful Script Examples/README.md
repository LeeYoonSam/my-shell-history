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
> 스크립트가 Linux 및 Windows에서 실행되는지 확인

Linux 쉘 스크립트는 Linux, Cygwin, Git Bash 등에서 실행되도록 작성할 수 있습니다.
그러나 스크립트에 환경에 대한 잘못된 줄 끝 문자가 있을 수 있습니다.
예를 들어 Git Bash를 사용하여 리포지토리를 복제하면 Windows에서 `CRLF` 문자가 사용됩니다.<br>
줄 끝에 `LF`만 있는 POSIX Linux 환경인 Cygwin을 사용하여 스크립트를 실행하려고 하면 다음과 유사한 오류가 표시될 수 있습니다.

```sh
./copy-to-owf-amazon-s3.sh: line 5: $'\r': command not found
./copy-to-owf-amazon-s3.sh: line 10: $'\r': command not found
./copy-to-owf-amazon-s3.sh: line 41: syntax error: unexpected end of file
```

해결 방법은 다음과 같이 스크립트에 두 번째 줄을 추가하는 것입니다. 이렇게 하면 줄 끝의 캐리지 리턴이 무시됩니다. 스크립트는 Linux와 Windows 셸 환경 간에 이식 가능합니다.

```sh
#!/bin/sh
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required
# The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL
#
# ... rest of the script...
```

Examples:
- [Open Water Foundation git-check.sh](https://github.com/OpenWaterFoundation/owf-util-git/blob/main/build-util/git-util/git-check.sh)

## Log Messages and Program Output
> 로그 메시지 및 프로그램 출력

프로그래밍 언어의 로깅 프레임워크와 유사하게 터미널 및/또는 로그 파일에 메시지를 인쇄하는 것이 종종 유용합니다. 로깅은 디버깅에 유용하고 스크립트가 실행될 때 사용자에게 피드백을 제공하는 데 유용합니다.

아래 함수는 스크립트에 삽입할 수 있으며 다음과 유사하게 호출할 수 있습니다.

```sh
scriptFolder=$(cd $(dirname "$0") && pwd)
scriptName=$(basename $scriptFolder)
# Start a log file that will be used by the logging functions
logFileStart ${scriptName} "${scriptFolder)/${scriptName}.log"

# The following logs the message string passed to the function.
# - use a space for empty lines because otherwise the logging function
#   will hang waiting for input
logInfo " "
logInfo "Starting to do some work."

# The following will log each `stdout` and `stderr` line piped to the function.
someOtherProgram 2>&1 | logInfo
```

출력은 다음과 유사합니다.

```sh
[DEBUG] some debug message
[INFO] some informational message
[WARNING] some warning message
[ERROR] some error message
```

삽입할 함수([logging-functions.txt](https://learn.openwaterfoundation.org/owf-learn-linux-shell/useful-scripts/resources/logging-functions.txt) 참조):

```sh
# Echo to stderr
echoStderr() {
  # - if necessary, quote the string to be printed
  # - redirect stdout from echo to stderr
  echo "$@" 1>&2
  # Or, use an alternate echo as discussed in "Echo colored text to console" example
  # ${echo2} "$@" 1>&2
}

# Print a DEBUG message
# - prints to stderr and optionally appends to log file if ${logFile} is defined globally
#   - see logFileStart() to start a log file
# - call with parameters or pipe stdout and stderr to this function: 2>&1 | logDebug
# - print empty lines with a space " " to avoid hanging the program waiting on stdin input
logDebug() {
  if [ -n "${1}" ]; then
    if [ -n "${logFile}" ]; then
      # Are using a log file
      echoStderr "[DEBUG] $@" 2>&1 | tee --append $logFile
    else
      # Are NOT using a log file
      echoStderr "[DEBUG] $@"
    fi
  else
    while read inputLine; do
      if [ -n "${logFile}" ]; then
        # Are using a log file
        echoStderr "[DEBUG] ${inputLine}" 2>&1 | tee --append $logFile
      else
        # Are NOT using a log file
        echoStderr "[DEBUG] ${inputLine}"
      fi
    done
  fi
}

# Print an ERROR message
# - prints to stderr and optionally appends to log file if ${logFile} is defined globally
#   - see logFileStart() to start a log file
# - call with parameters or pipe stdout and stderr to this function: 2>&1 | logError
# - print empty lines with a space " " to avoid hanging the program waiting on stdin input
logError() {
  if [ -n "${1}" ]; then
    if [ -n "${logFile}" ]; then
      # Are using a log file
      echoStderr "[ERROR] $@" 2>&1 | tee --append $logFile
    else
      # Are NOT using a log file
      echoStderr "[ERROR] $@"
    fi
  else
    while read inputLine; do
      if [ -n "${logFile}" ]; then
        # Are using a log file
        echoStderr "[ERROR] ${inputLine}" 2>&1 | tee --append $logFile
      else
        # Are NOT using a log file
        echoStderr "[ERROR] ${inputLine}"
      fi
    done
  fi
}

# Start a new logfile
# - name of program that is being run is the first argument
# - path to the logfile is the second argument
# - echo a line to the log file to (re)start
# - subsequent writes to the file using log*() functions will append
# - the global variable ${logFile} will be set for use by log*() functions
logFileStart() {
  local newLogFile now programBeingLogged
  programBeingLogged=$1
  # Set the global logfile, in case it was not saved
  if [ -n "${2}" ]; then
    logFile=${2}
  else
    # Set the logFile to stderr if not specified, so it is handled somehow
    logFile=/dev/stderr
  fi
  now=$(date '+%Y-%m-%d %H:%M:%S')
  # Can't use logInfo because it only appends and want to restart the file
  echo "Log file for ${programBeingLogged} started at ${now}" > ${logFile}
}

# Print an INFO message
# - prints to stderr and optionally appends to log file if ${logFile} is defined globally
#   - see logFileStart() to start a log file
# - call with parameters or pipe stdout and stderr to this function: 2>&1 | logInfo
# - print empty lines with a space " " to avoid hanging the program waiting on stdin input
logInfo() {
  if [ -n "${1}" ]; then
    if [ -n "${logFile}" ]; then
      # Are using a log file
      echoStderr "[INFO] $@" 2>&1 | tee --append $logFile
    else
      # Are NOT using a log file
      echoStderr "[INFO] $@"
    fi
  else
    while read inputLine; do
      if [ -n "${logFile}" ]; then
        # Are using a log file
        echoStderr "[INFO] ${inputLine}" 2>&1 | tee --append $logFile
      else
        # Are NOT using a log file
        echoStderr "[INFO] ${inputLine}"
      fi
    done
  fi
}

# Print an WARNING message
# - prints to stderr and optionally appends to log file if ${logFile} is defined globally
#   - see logFileStart() to start a log file
# - call with parameters or pipe stdout and stderr to this function: 2>&1 | logWarning
# - print empty lines with a space " " to avoid hanging the program waiting on stdin input
logWarning() {
  if [ -n "${1}" ]; then
    if [ -n "${logFile}" ]; then
      # Are using a log file
      echoStderr "[WARNING] $@" 2>&1 | tee --append $logFile
    else
      # Are NOT using a log file
      echoStderr "[WARNING] $@"
    fi
  else
    while read inputLine; do
      if [ -n "${logFile}" ]; then
        # Are using a log file
        echoStderr "[WARNING] ${inputLine}" 2>&1 | tee --append $logFile
      else
        # Are NOT using a log file
        echoStderr "[WARNING] ${inputLine}"
      fi
    done
  fi
}
```

## Parsing command line options
> 구문 분석 명령줄 옵션

스크립트를 작성할 때 일반적인 작업은 명령줄 옵션을 구문 분석하는 것입니다. 옵션은 다음과 같은 다양한 형태를 취할 수 있습니다.

옵션 | 설명
--- | ---
-a | 단일 문자 옵션
-a xyz | 인수가 있는 단일 문자 옵션
-abc | 단일 대시가 있는 긴 옵션
-abc xyz | 인수가 있는 단일 대시가 있는 긴 옵션
--aabc | 대시가 여러 개인 긴 옵션
--aabc xyz | 인수가 있는 여러 개의 대시가 있는 긴 옵션
--aabc=xyz | 여러 개의 대시가 있는 긴 옵션 및 등호를 사용한 할당

현재 Linux 규칙은 단일 대시 단일 문자(`-a`) 또는 이중 대시 긴 옵션(`--abc`)을 사용하는 것입니다. 단일 대시 긴 옵션(`-abc`)은 규칙에 따라 피해야 합니다. 사용자 지정 코드로 명령줄 옵션을 반복하여 옵션을 구문 분석할 수 있습니다. 그러나 다음 섹션에서는 표준 Linux 셸 기능을 사용하여 옵션을 구문 분석하는 방법을 설명합니다.

### Parsing command line options with built-in getopts
> 내장 getopts로 명령줄 옵션 구문 분석

`sh` 내장 `getopts` 기능을 사용하여 명령줄 구문 분석을 구현할 수 있습니다. 이 접근 방식은 단일 문자 옵션만 지원합니다.

- [getopts documentation](https://pubs.opengroup.org/onlinepubs/9699919799.2008edition/utilities/getopts.html)
- [Using getopts inside a Bash function](https://stackoverflow.com/questions/16654607/using-getopts-inside-a-bash-function)

예를 들어 다음과 유사한 함수를 만듭니다. 위의 두 번째 링크에서 설명한 것처럼 로컬 사용이 필요합니다. 기본 제공 `getopts` 명령에는 옵션 문자 뒤의 콜론이 후행 인수가 필요한지 여부를 나타내는 특정 구문이 있습니다. 예를 들어, 다음에서 `-i` 및 `-o` 인수는 파일 이름을 지정하는 데 사용됩니다. `optstring`의 시작 부분에 있는 콜론은 인수가 필요한 옵션이 오류를 처리하기 위해 실행되어야 하는 `:` case 문이 되어야 함을 나타냅니다.

```sh
# Parse the command line and set variables to control logic
parseCommandLine() {
    # Special case that nothing was provided on the command line so print usage
    # - include this if it is desired to print usage by default
    if [ "$#" -eq 0 ]; then
        printUsage
        exit 0
    fi
    local OPTIND opt h i o v
    optstring=":hi:o:v"
    while getopts $optstring opt; do
        #echo "Command line option is $opt"
        case $opt in
            h) # -h  Print usage
                printUsage
                exit 0
                ;;
            i) # -i inputFile  Get the input file
                inputFile=$OPTARG
                ;;
            o) # -o outputFile  Get the output file
                outputFile=$OPTARG
                ;;
            v) # -v  Print the version
                printVersion
                exit 0
                ;;
            \?) # Unknown single-character option
                echo ""
                echo "Invalid option:  -$OPTARG" >&2
                printUsage
                exit 1
                ;;
            :) # Option is recognized but it is missing an argument
                echo ""
                echo "Option -$OPTARG requires an argument" >&2
                printUsage
                exit 1
                ;;
        esac
    done
    # Get a list of all command line options that do not correspond to dash options.
    # - These are "non-option" arguments.
    # - For example, one or more file or folder names that need to be processed.
    # - If multiple values, they will be delimited by spaces.
    # - Command line * will result in expansion to matching files and folders.
    shift $((OPTIND-1))
    additionalOpts=$*
}
```

이 함수는 원래 명령줄 인수를 전달하여 호출해야 합니다.

```sh
parseCommandLine "$@"
```

Linux 명령줄에서 실행할 수 있는 전체 작업 예제를 참조하십시오(링크는 텍스트 파일을 표시하지만 컴퓨터에서 실행하기 위해 .sh 또는 확장자로 저장할 수 없습니다. 필요한 경우 sh parse-command-line-builtin- getopts.txt).

### Parsing command line options with getopt command
> getopt 명령으로 명령줄 옵션 구문 분석

내장된 getopts 구문은 긴 옵션을 처리할 수 없다는 점에서 제한적입니다. 이 제한은 getopts Linux 명령(셸에 내장되지 않고 대신 호출되는 명령)을 사용하여 극복할 수 있습니다.

- [getopt man page](https://linux.die.net/man/1/getopt)
- [TutorialsPoint getopt tutorial](https://www.tutorialspoint.com/unix_commands/getopt.htm)

아래 코드는 getopt 명령을 사용하여 명령줄을 구문 분석하는 함수의 예입니다. 다음 사항에 유의하십시오.
- `getopt` 명령은 인수가 없는 경우, 필수 인수 및 선택적 인수에 대해 짧은(`-a`) 및 긴(`--abc`) 인수를 처리할 수 있습니다.
- 옵션에 선택적 인수가 있는 경우 `-o=argument` 또는 `--option=argument` 구문을 사용해야 합니다.
- 단일 대시 롱 옵션(`-abc`) 처리는 명시적 기능이 아닙니다. b와 c가 인식되지 않는 단일 문자 옵션이라는 오류가 생성될 수 있습니다.
- getopt 명령은 기본적으로 특수한 경우를 처리할 수 있도록 명령줄을 구문 분석하고 다시 만듭니다.
    - 누락된 선택적 인수는 작은따옴표로 묶인 빈 문자열로 출력됩니다.
    - `--option=argument`로 지정된 옵션은 공백으로 구분된 `--option` 인수로 출력됩니다.
- `-h가` `--` 앞에 지정되면 `getopt` 도움말이 인쇄됩니다. `getopt` `--` 옵션 뒤에 구문 분석할 명령줄을 입력해야 합니다.
- 옵션을 확인하는 데 사용되는 `case` 문은 선행 대시(들)와 함께 전체 옵션 값을 사용합니다. 이는 `case 문`에 대시가 사용되지 않는 내장 `getopts` 기능과 다릅니다.
- 아래 코드는 `shift`를 사용하여 옵션 및 인수를 통해 구문 분석을 진행해야 합니다. `getopt`는 원래 명령줄을 더 간단한 구문으로 다시 형식화하고 잘못된 입력이 감지되면 오류를 생성하기 때문에 절대 안전합니다.
- `getopt`가 오류를 생성하기 때문에 누락된 인수 또는 알 수 없는 인수와 같은 사용자 지정 오류 처리를 수행할 방법이 없습니다. `optstring`의 시작 부분에 콜론을 지정할 수 있는 내장 `getopts`와는 다릅니다.

getopt 호출 자체는 아무 것도 인쇄하지 않습니다.
```sh
$ getopt --options "hi:o::v"
```

그러나 옵션을 전달하면 "nice" 명령줄이 출력됩니다. `--`는 명령줄의 끝을 나타내기 위해 출력되며 빈 문자열이 지정되지 않았기 때문에 출력 파일에 삽입되었습니다.

```sh
$ getopt --options "hi:o::v" -- -h -v -o
 -h -v -o '' --
```

다음은 명령줄을 구문 분석하는 함수의 코드입니다.

```sh
# Parse the command line and set variables to control logic
parseCommandLine() {
    # Special case that nothing was provided on the command line so print usage
    # - include this if it is desired to print usage by default
    if [ "$#" -eq 0 ]; then
        printUsage
        exit 0
    fi
    # Indicate specification for single character options
    # - 1 colon after an option indicates that an argument is required
    # - 2 colons after an option indicates that an argument is optional, must use -o=argument syntax
    optstring="hi:o::v"
    # Indicate specification for long options
    # - 1 colon after an option indicates that an argument is required
    # - 2 colons after an option indicates that an argument is optional, must use --option=argument syntax
    optstringLong="help,input-file:,output-file::,version"
    # Parse the options using getopt command
    # - the -- is a separator between getopt options and parameters to be parsed
    # - output is simple space-delimited command line
    # - error message will be printed if unrecognized option or missing parameter but status will be 0
    # - if an optional argument is not specified, output will include empty string ''
    GETOPT_OUT=$(getopt --options $optstring --longoptions $optstringLong -- "$@")
    exitCode=$?
    if [ $exitCode -ne 0 ]; then
        echo ""
        printUsage
        exit 1
    fi
    # The following constructs the command by concatenating arguments
    # - the $1, $2, etc. variables are set as if typed on the command line
    # - special cases like --option=value and missing optional arguments are generically handled
    #   as separate parameters so shift can be done below
    eval set -- "$GETOPT_OUT"
    # Loop over the options
    # - the error handling will catch cases were argument is missing
    # - shift over the known number of options/arguments
    while true; do
        #echo "Command line option is $opt"
        case "$1" in
            -h|--help) # -h or --help  Print usage
                printUsage
                exit 0
                ;;
            -i|--input-file) # -i inputFile or --input-file inputFile  Specify the input file
                # Input file must be specified so $2 can be used
                inputFile=$2
                shift 2
                ;;
            -o|--output-file) # -o outputFile or --output-file outputFile  Specify the output file
                case "$2" in
                    "")  # No output file so use default (check elsewhere)
                        outputFile="stdout"
                        shift 2  # Because output file is an empty string $2=''
                        ;;
                    *) # Output file has been specified so use it
                        outputFile=$2
                        shift 2  # Because output file is $2
                        ;;
                esac
                ;;
            -v|--version) # -v or --version  Print the version
                printVersion
                exit 0
                ;;
            --) # No more arguments
                shift
                break
                ;;
            *) # Unknown option - will never get here because getopt catches up front
                echo ""
                echo "Invalid option $1." >&2
                printUsage
                exit 1
                ;;
        esac
    done
    # Get a list of all command line options that do not correspond to dash options.
    # - These are "non-option" arguments.
    # - For example, one or more file or folder names that need to be processed.
    # - If multiple values, they will be delimited by spaces.
    # - Command line * will result in expansion to matching files and folders.
    shift $((OPTIND-1))
    additionalOpts=$*
}
```

이 함수는 원래 명령줄 인수를 전달하여 호출해야 합니다.

```sh
parseCommandLine "$@"
```

[Linux 명령줄에서 실행할 수 있는 전체 작업 예제](https://learn.openwaterfoundation.org/owf-learn-linux-shell/useful-scripts/resources/parse-command-line-getopt-command.txt)를 참조하십시오(링크는 텍스트 파일을 표시하지만 컴퓨터에서 실행하기 위해 .sh 또는 확장자로 저장할 수 없습니다. 필요한 경우 sh parse-command-line-getopt-로 실행하십시오. 명령.txt).


## Set Terminal Title
> 터미널 제목 설정

터미널이 환경에 대해 구성되었음을 나타내기 위해 터미널 창의 제목을 설정하는 것이 유용할 수 있습니다.

예를 들어 스크립트를 실행하여 `PATH` 및 기타 환경 변수를 구성할 수 있습니다. 터미널의 제목을 설정하려면 확장 문자와 함께 `echo` 명령을 사용하십시오.

예를 들어 다음 스크립트는 터미널 제목을 설정하는 함수를 보여줍니다.
```sh
#!/bin/bash

# example-termtitle

# Function to set the title of the terminal for the configured environment
# See:  https://askubuntu.com/questions/22413/how-to-change-gnome-terminal-title
setTerminalTitle () {
    local title
    title=$1
    echo -ne "\033]0;${1}\007"
}

# The function can also added to the $HOME/.bashrc file and then add an alias:
# alias termtitle=setTerminalTitle
# 
# Then run this script on the command line with:
#   example-termtitle title
#   example-termtitle "title title with spaces"

# Entry point into script

if [ ! -z "$1" ]; then
    # If an argument was provided, use it to set the terminal title
    setTerminalTitle "$1"
fi
```