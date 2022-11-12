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
## Functions
## Function and Command Return Status for Error Handling
## "Here Document" to Include Text in Script
## Scope of Variables
