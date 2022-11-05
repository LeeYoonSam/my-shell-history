# [Select and Install Shell Software](https://learn.openwaterfoundation.org/owf-learn-linux-shell/install/install/)
> Linux 셸을 선택하면 셸 스크립팅 언어의 기능이 정의됩니다.<br/>
> 셸 명령 프로그램과 셸 스크립트를 실행하기 전에 Linux 셸 소프트웨어를 설치해야 합니다.</br>
> sh 및 bash와 같은 기본 셸 프로그램은 Linux 환경에 이미 설치되어 있지만 다른 프로그램은 추가로 설치할 수 있습니다.

이 페이지에서는 다양한 셸 프로그램을 설치하는 방법과 사용할 셸에 대한 배경 정보를 제공합니다.

## Choosing a Linux Shell
> 많은 Linux 셸을 사용할 수 있으며 종종 sh와 같은 공통 조상에서 파생됩니다.

- [Comparison of command shells](https://en.wikipedia.org/wiki/Comparison_of_command_shells)

명령 셸을 선택하는 것은 일반적으로 다음을 포함하여 몇 가지 고려 사항으로 요약됩니다.
- 환경의 기본값은 무엇입니까?
- 다른 환경에서 쉘의 가용성은 얼마입니까(이식성)?
- 쉘이 표준을 준수합니까?
- 쉘의 기능은 무엇입니까?
- 셸의 성능은 무엇입니까(로드 및 실행 속도)?

`Bourne 셸(sh 프로그램)`은 대부분의 Linux 시스템에 배포되며 자동화된 작업을 위한 공통 기능 집합을 제공합니다.

`bash 셸`은 또한 대부분의 Linux 시스템과 함께 배포되며 사용자가 상호 작용하는 명령 프롬프트를 제공하는 로그인 셸을 위한 것입니다.

`bash 셸`은 `sh`보다 시작 및 실행 속도가 느리므로 성능이 주요 고려 사항인 경우 `sh`가 선호되며 실행 시간을 비교하여 이것이 문제인지 확인할 수 있습니다.

`bash 셸`은 대화형 환경에서 사용되는 명령 완성과 같은 유용한 명령줄 기능을 제공합니다.

**일반적인 지침은 성능이나 이식성에 대한 우려가 없는 한 bash의 성능과 기능을 사용하는 것입니다.**

- [sh man page](https://man7.org/linux/man-pages/man1/sh.1p.html)
- [bash man page](https://man7.org/linux/man-pages/man1/bash.1.html)

일부 시스템에서 쉘은 특정 버전으로 별명을 붙였습니다. 예를 들면: `sh`는 `bash`와 동일합니다.

이것이 발생하는지 여부를 판별하려면 프로그램 파일에 대해 긴 목록을 작성하여 기호 링크가 사용되는지 또는 파일 크기가 동일한지 확인하십시오. 파일 크기가 같으면 `diff` 프로그램을 사용하여 확인할 수 있습니다.
예를 들어, `Cygwin`에서 실행되는 다음은 `sh`와 `bash`가 동일함을 나타냅니다.

이것은 다른 Linux 운영 체제가 다른 기본값을 가질 수 있고 이식 가능한 스크립트를 보장하기 위해 쉘에서 어떤 기능을 사용할 수 있는지 아는 것이 중요하기 때문에 중요합니다.

```shell
$ ls -l /bin/sh /bin/bash
-rwxr-xr-x 2 SystemAdmin None 723K Jan 27  2017 /bin/bash*
-rwxr-xr-x 2 SystemAdmin None 723K Jan 27  2017 /bin/sh*
$ diff /bin/sh /bin/bash
$
```

궁극적인 선택은 셸 스크립트를 만드는 프로그래머에 따라 다릅니다.
쉘 스크립트 프로그래머는 `sh`에 능숙해야 하고 `bash`가 이점을 제공하는 부분을 배워야 합니다.
이 문서의 나머지 부분에서 논의는 일반적으로 `bash` 주제가 명확하게 표시된 `sh`에 중점을 둡니다.

다음 명령을 사용하여 셸이 열린 후 프로그램을 사용할 수 있는지 확인합니다.

```shell
$ which sh

$ which bash
```

다음 표에는 선택할 Linux 환경 및 셸에 대한 정보가 나와 있습니다.

쉘 스크립트를 작성할 때 종종 여러 Linux 환경에서 스크립트를 지원해야 하므로 다음 Linux 환경 중 하나 이상을 사용할 수 있습니다.

**Selecting a Linux Shell**
Shell | Reasons to Use | Reasons to Not Use
--- | --- | ---
bash | - 대화식 세션에 사용됩니다.<br> - 문서화된 예제와 함께 sh 기능 외에 유용한 기능을 제공합니다.<br> - 배열 <br> - 파이프된 명령 시퀀스에서 명령 상태를 가져오기 위한 PIPESTATUS.| 더 느리고 동일한 기본 명령이 아닌 경우 sh보다 더 많은 리소스를 사용합니다. 이 경우 sh와 bash는 동일한 리소스를 사용합니다.
sh | 프로세스가 반복되고 빠르게 완료되어야 하는 경우 빠르게 실행됩니다. | bash에 있는 일부 기능을 제공하지 않습니다.

---

## Installing a Shell on Linux
> 대부분의 경우 설치된 기본 셸 프로그램으로 충분하지만 때로는 다른 셸 프로그램을 설치하는 것이 유용합니다. Linux에 셸 프로그램을 설치하려면 프로그램의 패키지 이름을 확인한 다음 해당 Linux 버전에 대한 설치 프로그램을 실행해야 합니다.

예를 들어, `Cygwin` 설치 프로그램은 사용 가능한 셸을 나열하고 `Linux` 배포는 일반적으로 `apt-get`과 같은 설치 프로그램을 사용합니다.

Linux 버전에 대한 Linux 소프트웨어 설치 지침을 참조하십시오.

## Installing Cygwin
> Cygwin 소프트웨어는 Windows에서 실행되는 무료 오픈 소스 Linux 구현입니다.
Cygwin 프로그램은 Windows에서 실행되도록 컴파일되어 있으므로 Cygwin 셸은 Windows 프로그램을 실행할 수 있습니다.<br/>
Cygwin 설치 프로그램은 기본적으로 sh 및 bash를 설치하며 추가 셸 및 프로그램을 설치할 수 있습니다. Cygwin은 생산성을 높이는 데 매우 유용한 환경입니다.

- [Open Water Foundation / Learn Cygwin](https://learn.openwaterfoundation.org/owf-learn-cygwin/)
- [Cygwin website](https://www.cygwin.com/)


## Installing MinGW
> MinGW는 UNIX의 무료 및 오픈 소스 버전을 제공하기 위한 GNU 소프트웨어 프로젝트입니다.<br>
Open Water Foundation은 일반적으로 Windows용 Git과 같은 다른 소프트웨어 도구의 일부가 아닌 한 MinGW를 설치하지 않습니다.<br>
예를 들어 Git For Windows가 설치되어 있으면 MinGW를 어떤 형태로든 사용할 수 있으므로 명령 셸을 사용할 수 있습니다.
- [Minimalist GNU for Windows](http://www6.mingw.org/?template=ARROW_3&tdfs=0&s_token=1667633674.0389440000&uuid=1667633674.0389440000&term=C%20Language%20Compiler&term=GCC%20Compiler&term=Test%20Code%20Online&searchbox=0&showDomain=0&backfill=0)


## Installing Git for Windows (Git Bash)
> Windows용 Git은 소프트웨어 개발자 및 Git 버전 제어 시스템을 사용하여 전자 파일 버전을 추적하고 전자 파일 편집에 대해 다른 사람과 공동 작업하는 사람들이 설치하는 경우가 많습니다. Windows용 Git은 MinGW 및 Git Bash도 설치합니다.

- [Git](https://git-scm.com/)

## Installing the Linux Subsystem on Windows 10
> 다음은 Windows 10에서 Linux 하위 시스템을 활성화/설치하는 방법을 설명합니다. Microsoft는 현재 개발자를 돕기 위해 Linux 버전을 출시하고 있습니다.

### [Windows 10에서 Linux Bash 셸을 설치하고 사용하는 방법](https://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/)

- 위에 표시된 대로 Linux용 Windows 하위 시스템을 활성화한 후 위 지침에 표시된 대로 앱 스토어를 방문하여 Linux 버전을 설치합니다. 우분투를 권장합니다.
- 위에 표시된 대로 설치 후 Linux 셸에서 사용할 로그인 및 암호를 지정합니다.
