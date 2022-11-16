# [5. Shell Script Best Practices](https://learn.openwaterfoundation.org/owf-learn-linux-shell/best-practices/best-practices/)

이 페이지에는 업계 표준 및 직접 경험을 기반으로 한 모범 사례가 나열되어 있습니다.

- [Use simple shell scripts to memorialize tasks](#use-simple-shell-scripts-to-memorialize-tasks)
- [Use version control](#use-version-control)
- [Indicate the shell to run in the first line of shell scripts](#indicate-the-shell-to-run-in-the-first-line-of-shell-scripts)
- [Write code that is understandable](#write-code-that-is-understandable)
- [Check whether the script is running in the correct folder](#check-whether-the-script-is-running-in-the-correct-folder)
- [Echo useful troubleshooting information](#echo-useful-troubleshooting-information)
- [Consider options for logging](#consider-options-for-logging)
- [Create documentation](#create-documentation)
- [Include useful web resource links in shell script comments](#include-useful-web-resource-links-in-shell-script-comments)
- [Learn how to use shell features](#learn-how-to-use-shell-features)
- [Use functions to create reusable blocks of code](#use-functions-to-create-reusable-blocks-of-code)

## Use simple shell scripts to memorialize tasks
> 작업을 기념하기 위해 간단한 쉘 스크립트 사용

작업을 완료하기 위해 데이터를 처리하거나 프로그램 호출을 자동화하기 위해 여러 단계를 수행해야 하는 경우가 많습니다.
이러한 단계는 일회성 작업일 수 있지만 나중에 자주 반복해야 합니다. 서면 또는 전자 메모, 이메일 등에 의존하는 대신 작업을 기념하는 짧은 쉘 스크립트를 생성하면 지식을 유지할 수 있습니다.
더 많은 기능을 제공하기 위해 시간이 지남에 따라 스크립트를 향상시킬 수도 있습니다.

유용한 모범 사례는 처리 중인 파일에 간단한 셸 스크립트를 만들고 셸 스크립트의 용도와 용도를 설명하는 주석을 포함하는 것입니다. 또한 `README.md` 파일을 생성하여 쉘 스크립트에 대한 형식화된 설명을 제공할 수 있습니다.

스크립트와 `README.md` 파일은 버전 제어 시스템에서 관리하여 시간 경과에 따른 변경 사항을 추적하고 백업 역할을 할 수 있습니다.

## Use version control
> 버전 제어 사용

만들고 사용할 가치가 있는 모든 스크립트는 버전 제어 시스템에서 추적할 가치가 있을 것입니다. "내가 그 스크립트를 어디에 두었지?"라고 묻는 것보다 더 답답한 것은 없습니다. 따라서 Git 및 GitHub 또는 Bitbucket과 같은 클라우드 호스팅 버전 제어 시스템을 사용하여 스크립트를 유지 관리하십시오. 예를 들어 저장소 문제 페이지를 통해 질문과 버그를 처리할 수 있도록 작성자에 대한 정보를 제공합니다.

실제 버전 제어 시스템을 사용하지 않는 경우 스크립트를 지식 기반 또는 기타 정보 플랫폼에 저장할 수도 있습니다.

## Indicate the shell to run in the first line of shell scripts
> 쉘 스크립트의 첫 번째 줄에서 실행할 쉘을 나타냅니다.

쉘 스크립트(실제로 모든 스크립트)는 다양한 언어와 언어 표준으로 작성될 수 있습니다. 쉘 스크립트는 sh, bash 또는 기타 명령 쉘용으로 작성할 수 있습니다. 사용될 기본 명령 셸이 올바르다고 가정하지 마십시오.
따라서 항상 실행할 셸을 지정하십시오. 

예를 들면 다음과 같습니다.
```sh
#!/bin/sh
#
# The above indicates that the Bourne shell `sh` command shell will be used to run the script.
```

## Write code that is understandable
> 이해할 수 있는 코드 작성

단순히 원래 작성자의 작업을 이해할 수 없기 때문에 코드를 다시 작성하는 것이 일반적입니다.
이로 인해 추가 비용, 잠재적인 버그, 원래 코드를 이해하지 못하는 경우 잠재적인 기능 손실이 발생합니다. 코드를 다시 작성하려는 충동은 문서의 부족, 혼란스러운 논리, 잘못된 프로그래밍 스타일, 설명 없이 모호하거나 고급 언어 구문 사용 또는 기타 이유 때문일 수 있습니다.

코드를 작성하는 시점에 코드를 문서화하는 것이 코드를 문서화하기에 가장 좋은 시기입니다. 코드를 업데이트하는 경우 코드 주석을 다시 읽고 이해가 되지 않는 경우 주석을 명확히 합니다. 간단한 규칙은 `이 코드를 작업하는 다음 사람이 이해할 수 있습니까?`라고 묻는 것입니다.

다음은 코드를 이해하기 쉽게 만들기 위한 몇 가지 기본 지침입니다.
- 코드에 전체 문법 주석을 추가합니다. 사람들에게 당신이 의미하는 바를 추측하도록 강요하지 마십시오. 적절한 문법을 ​​사용하십시오. 엉성한 주석과 불완전한 생각은 엉성한 코드를 나타낼 수 있습니다.
- 복잡한 구문을 설명합니다. 다음 프로그래머가 쉘 스크립팅 박사 학위를 가질 것이라고 가정하지 마십시오. 예, 모든 대답은 웹에서 찾을 수 있지만 웹에는 오해의 소지가 있고 오래된 예가 많이 포함되어 있습니다.
- 컨텍스트를 제공하기에 충분한 변수 및 함수 이름을 사용하십시오. 코드는 명확한 프로세스처럼 읽어야 합니다. 적절한 이름을 사용하면 코드 주석의 필요성도 줄어듭니다.
- 이름과 스타일에 일관성을 유지하십시오. 다른 사람의 코드를 편집하는 경우 가능하면 원래 스타일과 일치하도록 노력하십시오.
- 문자열을 표시하려면 문자열 주위에 큰따옴표나 작은따옴표를 적절하게 사용하십시오.
- 적절한 들여쓰기를 일관되게 사용하십시오. 탭은 괜찮으며 사용하는 경우 공백과 함께 사용하면 안 됩니다. 사용하는 경우 공백은 2~4개 그룹이어야 합니다. 코드를 편집할 다음 사람이 편집기에서 동일한 규칙을 사용할 것이라고 가정하지 말고 일관성을 유지하여 사용 중인 항목을 명확하게 만드십시오.

## Check whether the script is running in the correct folder
> 스크립트가 올바른 폴더에서 실행 중인지 확인

스크립트가 실행되는 폴더는 종종 스크립트의 기능에 큰 영향을 미칩니다. 옵션은 다음과 같습니다.
1. 작업이 위치에 의존하지 않으므로 모든 폴더에서 스크립트를 실행할 수 있습니다.
2. 스크립트가 모든 폴더에서 실행되도록 허용하고 환경 내에서 사용자의 홈 폴더 또는 표준 폴더 구조를 감지하는 것과 같이 환경을 기반으로 입력 및 출력을 찾습니다.
3. 입력 및 출력 폴더는 실행 폴더에 상대적이므로 특정 폴더에서 스크립트를 실행해야 합니다.

입력 파일을 찾고 적절한 위치에 출력을 생성하기 위해 스크립트가 모든 폴더에서 올바르게 실행되도록 하려면 스크립트 코드에서 많은 노력을 기울여야 할 수 있습니다.
그러나 간단한 작업의 경우 특정 폴더에서 실행해야 하는 것이 더 쉬울 수 있습니다.

가장 좋은 방법은 필요한 경우 스크립트가 올바른 폴더에서 실행되고 있는지 확인하는 것입니다.

예를 들어 다음은 스크립트가 build-util 폴더에서 실행 중인지 확인하기 위한 간단한 검사입니다. 다음 검사는 하나의 build-util 폴더에서 실행하고 다른 build-util 폴더에 대한 경로를 지정하면 테스트를 통과할 것이기 때문에 완벽하지는 않지만 기본 검사는 많은 문제를 방지하는 데 도움이 됩니다.

```sh
# Make sure that this is being run from the build-util folder
pwd=`pwd`
dirname=`basename ${pwd}`
if [ ! ${dirname} = "build-util" ]
    then
    echo "Must run from build-util folder"
    exit 1
fi
```

보다 강력한 솔루션은 `PATH`에서 찾거나 스크립트 경로를 수동으로 지정하는 것을 포함하여 모든 폴더에서 스크립트를 실행할 수 있도록 하는 것입니다. 이 경우 다음 구문을 사용하여 스크립트의 위치를 ​​결정할 수 있으며 표준이 있다고 가정하면 해당 위치를 기준으로 다른 폴더와 파일을 찾을 수 있습니다.

```sh
# Get the location where this script is located since it may have been run from any folder
scriptFolder=`cd $(dirname "$0") && pwd`
# Also determine the script name, for example for usage and version.
# - this is useful to prevent issues if the script name has been changed by renaming the file
scriptName=$(basename $scriptFolder)
```

## Echo useful troubleshooting information
> 유용한 문제 해결 정보 Echo

셸 스크립트는 특히 스크립트 코딩이 명확하지 않고 스크립트 사용자가 스크립트를 작성하지 않은 경우 문제를 해결하기 어려울 수 있습니다. 따라서 스크립트 시작 부분에 중요한 구성 정보를 인쇄하는 것이 종종 도움이 됩니다. 예를 들어 echo 문을 사용하여 중요한 환경 변수 이름과 값, 입력 파일 이름 등을 인쇄합니다.

스크립트가 더 발전된 경우 이러한 출력은 `--verbose`와 같은 명령줄 매개변수가 지정된 경우에만 인쇄될 수 있습니다.

## Consider options for logging
## Create documentation
## Include useful web resource links in shell script comments
## Learn how to use shell features
## Use functions to create reusable blocks of code