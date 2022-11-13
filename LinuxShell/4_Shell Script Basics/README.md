# [4. Shell Script Basics](https://learn.openwaterfoundation.org/owf-learn-linux-shell/shell-script-basics/shell-script-basics/)

> 다음은 인터넷에서 볼 수 있는 Bourne 셸 자습서입니다. 각 사이트의 목차 및 색인 기능을 사용하여 특정 쉘 스크립트 언어 기능에 대한 정보를 찾거나 인터넷을 검색하십시오.

- [Shell Script Tutorial](https://www.shellscript.sh/) - Bourne shell tutorial
- [Bourne Shell Programming](https://www.ooblick.com/text/sh/)
- [Linux Shell Scripting Tutorial - A Beginner's Handbook](http://www.freeos.com/guides/lsst/)
- [UNIX/Linux Tutorial from Tutorials Point](http://www.tutorialspoint.com/unix/)

유용한 쉘 구문의 예는 아래에 설명되어 있습니다. 다음은 시작하는 데 중요한 주제입니다.
- [First Line - Shebang](#first-line---shebang)
- [Script Main Entry Point](#script-main-entry-point)

다음 항목은 알파벳순으로 나열되어 있으며 쉘 스크립트 구문의 가장 유용한 기능 중 일부를 강조 표시합니다.
- [Arrays](#arrays)
- [Functions](#functions)
- [Function and Command Return Status for Error Handling](#function-and-command-return-status-for-error-handling)
- ["Here Document" to Include Text in Script](#here-document-to-include-text-in-script)
- [Scope of Variables](#scope-of-variables)

---

## First Line - Shebang
> `shebang("hashbang" 등)`은 셸 스크립트의 첫 번째 줄이며 스크립트를 실행하는 데 사용해야 하는 프로그램을 나타냅니다. 쉘 이외의 프로그램(예: Python 인터프리터)을 지정할 수 있습니다. 예를 들어, 

다음은 `sh` 쉘을 사용하여 스크립트를 실행함을 나타냅니다.
```sh
#!/bin/sh
```

다음은 bash 셸을 사용하여 실행하는 것을 나타냅니다.
```sh
#!/bin/bash
```

지정된 경로는 컴퓨터에서 찾아야 합니다. Unix/Linux 변종에는 일반적으로 중요한 프로그램을 찾기 위한 표준 폴더가 있습니다.

다른 곳에서 논의된 바와 같이, 표시된 쉘 프로그램은 일부 시스템에서 `sh`에 사용되는 `dash`와 같이 실제로 다른 프로그램을 사용할 수 있습니다. 스크립트가 가능한 많은 운영 체제에서 실행될 수 있도록 셸 프로그램이 표준을 얼마나 잘 준수하는지 이해하는 것이 중요합니다. 이를 확인하는 유일한 방법은 다른 운영 체제에서 스크립트를 실행하고 "맨 페이지"와 같은 시스템 설명서를 읽는 것입니다.

## Script Main Entry Point(스크립트 기본 진입점) 
> 셸 스크립트는 이전 섹션에서 설명한 것처럼 일반적으로 실행할 프로그램을 나타내는 "shebang" 줄인 첫 번째 줄에 입력됩니다. 그러면 쉘 스크립트 인터프리터가 스크립트를 구문 분석하고 해당 행을 순서대로 실행합니다. 쉘 스크립트 라인은 위에서 아래로 순차적으로 실행하기 위해 파일에서 순차적으로 코딩될 수 있습니다.

그러나 가장 좋은 방법은 가능한 한 많은 `function`을 사용하고 명확한 진입점을 제공하는 것입니다. 

예를 들면 다음과 같습니다.
```sh
#!/bin/bash
#

# Supporting functions, alphabetized

# This is function 1
function1() {
}

# This is function 2
function2() {
}

# Main entry point
# - define controlling variables here
# - include shell and Linux commands to run
# - call functions

version="1.0.0"
variable1="some value"

# Call functions
```
- 위의 디자인은 메인 코드에 대한 메인 스크립트 범위를 사용하여 필요할 때 함수를 호출할 수 있습니다.

또 다른 접근 방식은 스크립트에서 맨 위 또는 맨 아래에 즉시 호출되는 main() 함수를 갖는 것입니다. 이 함수는 다른 함수를 호출합니다.

```sh
#!/bin/bash

main() {
}

# Main entry point.  Call the main() function
main
```

---

## Arrays
> 배열은 데이터 값 목록을 관리하는 데 유용한 구조입니다. `sh` 쉘은 실제 배열을 표현하는 능력이 제한적이지만 `bash`는 광범위한 기능을 가지고 있습니다.

이 섹션을 완료해야 `sh` 및 `bash`에서 지원을 확인합니다.

### 참고
- [Unix / Linux - Using Shell Arrays](https://www.tutorialspoint.com/unix/unix-using-arrays.htm)

## Functions
> 일반적으로 가능한 경우 스크립트 코드를 함수로 구성하는 것이 좋습니다.
이것은 코드를 더 읽기 쉽게 만들고, 기능을 캡슐화하며, 함수를 복사할 수 있기 때문에 스크립트 간에 코드를 더 쉽게 복사하여 붙여넣을 수 있습니다.<br>
코드를 서로 호출하는 많은 작은 스크립트로 분할할 수 있지만 이것은 더 취약할 수 있습니다. 스크립트에 필요한 모든 기능이 포함되도록 하면 안정성이 제공됩니다. 함수의 일반적인 구문은 다음과 같으며 `sh` 및 `bash` 셸에서 작동합니다.

```sh
# Call a function
# - arguments are passed as if running a program on command line
functionName arg1 arg2

# Comments to document function
# - don't list arguments in the parentheses
functionName() {
    # Indicate which variables are have scope that is local to the function
    # - if a variable is not declared as "local", it be global to the script
    local arg1 arg2
    arg1=$1
    arg2=$2
    # Can use "shift" or parse arguments by looping, similar to parsing script commmand line

    # some logic here

    # Can return value the following ways
    # 1. Return an integer
    #    - this is similar to any program's main calling exit with a status,
    #      such as exit(0)
    #    - exit status of 0 means success and non-zero indicates error code
    #    - calling code can check value of $? but must assing to a variable
    #      immediately because $? gets reassigned to the exit code of the
    #      most-recently run program/command
    return 0

    # 2. Echo a string
    #    - calling code would assign a variable using returnVal=$(functionName arg1 arg2)
    # 
    echo "some return string"

    # 3. Use a script global scope variable
    #    - DO NOT declare the variable as "local" in the script
    #    - Can declare the variable and set an initial value in the main (global) scope
    #      or wait until function sets the value
}
```

## "Here Document" to Include Text in Script
다음과 같이 스크립트에 텍스트 블록을 포함하는 것이 종종 유용합니다.
- 각 텍스트 줄에 백슬래시 연속 문자를 추가하지 않아도 됩니다.
- 파일로 출력되지만 배포가 복잡하기 때문에 스크립트와 함께 별도의 파일을 배포하는 것은 바람직하지 않습니다.
- 사용자에게 표시될 여러 줄 메시지
- 데이터베이스 쿼리 프로그램과 함께 사용되는 SQL 문

쉘의 Here Document 기능은 필요한 기능을 제공합니다. 배경은 다음을 참조하십시오.
- [Here document on Wikipedia](https://en.wikipedia.org/wiki/Here_document)

다음 예는 here 문서의 사용자가 파일에 텍스트 블록을 출력하는 방법을 보여줍니다(예: 시스템에 패치 파일로). 예제는 here 문서를 파일로 리디렉션하는 방법을 보여줍니다.

```sh
#!/bin/sh
#
# example-here-doc-redirect

# Illustrate how to use a "here document" to populate a file that is needed for a system update.
# - this demonstrates how to redirect the here document to a file

# First might get the operating system and parse the returned string to determine specifics
operatingSystem=$(uname -a)
# Would have some logic to check for different operating systems
# - for this example just check for empty string
if [ ! -z "$operatingSystem" ]; then
    # Need to make sure that the patch file is in place
    # - use a here document to create the output file
    # - for this example just use a temporary file
    # - the __HERE_DOC__ string can be anything, as long as it bounds the text
    #   and is not found in the text
    # - using single quotes around __HERE_DOC indicates to the shell to NOT expand variables
    #   (for example don't convert $variable to its value)
    patchFile="$(mktemp).patch"
    cat << '__HERE_DOC__' > $patchFile
This is text that is part of the patch.
Because single quotes were used around the here doc string,
a variable like $PATH won't be expanded.
There are other modifiers to the here doc string that can be used
(see reference documentation).
__HERE_DOC__
fi

echo "Created patch file $patchFile:"
cat $patchFile
```

다음 예는 here 문서를 다른 명령으로 파이프하는 방법을 보여줍니다. 예를 들어 명령줄 쿼리 도구에 대한 SQL 문을 형식화하는 데 사용할 수 있습니다.

```sh
#!/bin/sh
#
# example-here-doc-pipe

# Illustrate how to use a "here document" to pipe text to a command line program.

# Set variables to the values used in a query
queryVal1="something"
queryVal2="somethingElse"

# In the following example, cat just prints the text,
# but if a database query program is used it would actually query a database
# and return results, such as comma-separated-value result set.
# - note that the output string has been expanded with variable values
# - a simple awk program is used to print the expanded result and
#   in a more substantial program would process the query result
# - the receiving command is provided starting on the line immediately
#   after the trailing __HERE_DOC__ string.
    cat << __HERE_DOC__ |
SELECT * from table where val1=${queryVal1} and val2='${queryVal2}'
__HERE_DOC__
    awk '
    { print $0 }
    '
```
위 스크립트의 출력은 다음과 같습니다.
```sh
SELECT * from table where val1=something and val2='somethingElse'
```

## Function and Command Return Status for Error Handling
## Scope of Variables
