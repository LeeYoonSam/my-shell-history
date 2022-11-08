# [3. User Environment Basics](https://learn.openwaterfoundation.org/owf-learn-linux-shell/user-env/user-env/)
> 명령 셸은 핵심 운영 체제와 다른 프로그램 사이에서 작동합니다. 따라서 쉘이 작업을 수행하려면 일정량의 시작 정보를 구성해야 합니다.<br>
이 페이지에서는 특히 Windows 환경에서 다양한 Linux 환경 및 셸에 대한 기본 구성 및 상호 작용에 대해 설명합니다.

## Location of Software Files(소프트웨어 파일 위치)
> 각 Linux 환경에 대한 소프트웨어 파일은 환경에 따라 표준 폴더에 있습니다. 이러한 파일은 Linux 환경의 기능을 제공합니다. 소프트웨어 파일을 처리하는 것은 불필요할 수 있습니다. 그러나 문제 해결 등을 위해 파일이 있는 위치를 아는 것이 도움이 됩니다. 다음 표에는 각 Linux 환경에 대한 소프트웨어 위치가 요약되어 있습니다.

Environment | Software File Location (from shell) | Software File Location (from Windows)
--- | --- | ---
Cygwin | `/` | `C:\cygwin64`
Git for Windows | `/` | `C:\Program Files\Git`
Linux | [Filesystem Hierarchy Standard on Wikipedia](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) | Not applicable
Linux Subsystem on Windows 10 | `/` | ?
MinGW | ? | `C:\MinGW`

## Location of User Files(사용자 파일 위치)
> 각 Linux 환경에 대한 사용자 파일은 환경에 따라 표준 폴더에 있습니다.<br>
Linux 환경의 사용자 파일은 일반적으로 명령 셸 프로그램에 내장된 링크 또는 논리를 통해 Windows 파일 시스템(Windows에 설치된 경우)과 공유됩니다. 다음 표에는 각 Linux 환경에 대한 사용자 파일 위치가 요약되어 있습니다. 여기서 `user`는 사용자 이름입니다. Linux `pwd` 명령은 예를 들어 명령 셸을 연 후 현재 작업 디렉토리를 확인하는 데 사용할 수 있습니다.

Environment	| Linux User File Location (from Linux) | Linux User File Location (from Windows) | Windows User File Location (from Linux) | Windows User File Location (from Windows)
--- | --- | --- | --- | ---
Cygwin | `/home/user` | `C:\cygwin64\home\user` | `/cygdrive/C/Users/user` | `C:\Users\user`
Git for Windows (Git Bash) | `/c/Users/user` | `C:\Users\user` | `/c/Users/user` | `C:\Users\user`
Linux | `/home/user` | Not applicable | Not applicable | Not applicable
Linux Subsystem on Windows 10 | `/home/user` | `C:\Users\sam\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_abcd123etc\LocalState\rootfs\home\sam` | `/mnt/c`, etc. | `C:\Users\user`
MinGW | ? | `C:\MinGW\msys\1.0\home\user` |	? | `C:\Users\user`

Linux 및 Windows 파일은 동일한 위치에 있거나 별개일 수 있습니다.

예를 들어 Git Bash 사용자 파일은 Windows 사용자 파일과 동일한 위치에 있습니다.
그러나 Cygwin 설치에는 Cygwin에 특정한 사용자 파일에 대한 `/home` 아래에 하나의 파일 세트가 있으며 Windows 사용자 파일(`/cygdrive/C/Users/user`)에 액세스하기 위한 `/cygdrive` 폴더도 제공합니다.

### 참고
- [Environment Variables](https://learn.openwaterfoundation.org/owf-learn-linux-shell/user-env/user-env/#environment-variables)


## Login Shell and Shell Script Shell(로그인 셸 및 셸 스크립트 셸)
> Linux 명령 셸을 로그인 셸로 사용하거나 셸 스크립트를 실행할 수 있습니다. Linux 명령 셸은 셸 창이 열릴 때 사용되며 명령 셸 프롬프트를 제공합니다. 실행 중인 명령 셸은 ps(프로세스 상태) 명령을 실행하여 나열할 수 있습니다.

```shell
$ ps
      PID    PPID    PGID     WINPID   TTY         UID    STIME COMMAND
    14148   14320   14148      11836  pty0        1001   Nov 28 /usr/bin/bash
     9032       1    9032       9032  ?           1001   Nov 28 /usr/bin/mintty
S   19264   14148   19264       5892  pty0        1001 23:47:44 /usr/bin/vim
```
- 위에서 bash 쉘이 실행되고 있는것을 볼수 있습니다.

쉘 스크립트는 쉘 스크립트에 표시된 명령 쉘을 사용하여 상위 명령 쉘에서 실행됩니다.

어떤 프로그램이 스크립트에 사용되어야 하는지를 나타내는 쉘 스크립트의 첫 번째 라인에 대한 표준이며, 프로그램은 명령 쉘 또는 다른 프로그램이 될 수 있습니다. 
예를 들어, 쉘 스크립트 상단에 있는 다음 주석은 표준 Linux 소프트웨어 설치 폴더에 있는 `sh` 명령 쉘 프로그램으로 스크립트를 실행하라는 의미입니다.

```shell
#!/bin/sh
#
# This script will be run with the Bourne shell
```

`bash` 명령 셸을 로그인 셸로 사용하고 sh와 같은 다른 명령 셸을 사용하여 다른 프로그램을 실행하는 것이 일반적입니다.

예를 들어, sh는 기능이 더 적은 경우 로드 및 실행이 더 빠를 수 있습니다. 그러나 일부 시스템에서는 `sh`와 `bash`가 동일할 수 있으며 성능에 차이가 없습니다.


## Shell Configuration Files(셸 구성 파일)
> 사용자의 홈 폴더에 있는 파일을 수정하여 사용자에 대해 명령 셸 프로그램을 구성할 수 있습니다. 구성 파일은 사용 중인 쉘에 따라 다릅니다. 소프트웨어를 설치할 때 구성 변경이 필요한 경우가 많으며 이러한 변경은 설치 중에 자동으로 발생하거나 사용자가 텍스트 편집기를 사용하여 변경해야 할 수 있습니다.

### `bash` Configuration Files
`bash` 명령 셸은 로그인 셸에 자주 사용되며 다음과 같은 기능을 제공합니다.
- command completion(명령 완료) - 예를 들어 탭 키는 파일 이름을 완성합니다.
- command prompt customization(명령 프롬프트 사용자 정의) - 예를 들어 현재 폴더 표시
- command aliases(명령 별칭) - 예를 들어 별칭 la에서 ls -a로 모든 파일을 나열합니다.

다음 `bash` 구성 파일은 `bash` 셸 환경을 구성하는 데 사용됩니다.
- `.bash_profile` - 로그인 셸에 대해 실행됩니다.
- `.bashrc` - 대화형 비 로그인 셸 및 셸 스크립트를 실행할 때 실행됩니다.

Linux에서 이름이 마침표로 시작하는 파일 및 폴더는 숨김으로 처리되며 기본적으로 ls 명령으로 나열되지 않습니다(모든 파일을 나열하려면 ls -a 사용). 이 두 파일은 모두 사용자의 홈 폴더에 만들 수 있습니다. 중복을 피하기 위해 다음과 같이 .bash_profile 파일에서 .bashrc 파일을 호출할 수 있습니다.

```shell
# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi
```

## Environment Variables
> 명령 셸 프로그램은 환경 변수를 사용하여 중요한 구성 정보를 보유합니다. 이것은 사용자의 계정 이름과 같은 중요한 데이터에 대한 액세스를 단순화합니다.
표준 Linux는 표준 환경 변수를 정의하고 각 셸도 환경 변수를 정의합니다.
예를 들어 `HOME` 환경 변수는 사용자의 홈 폴더를 나타냅니다.

환경 변수는 쉘 스크립트의 일반 변수와 별개입니다. 일반 변수는 셸 스크립트에서만 볼 수 있으며 셸 스크립트가 완료되면 삭제됩니다.

다음은 쉘 스크립트에서 일반 변수와 환경 변수를 설정하는 방법을 보여줍니다.

```shell
normalVariable="test value"
export ENVIRONMENT_VARIABLE="test value"
```
- 환경 변수의 이름은 모두 대문자로 지정하는 것이 일반적입니다.

다음 명령을 사용하여 모든 환경 변수 목록을 표시할 수 있습니다.
```shell
$ env
$ set
```

다음과 유사한 구문을 사용하여 단일 환경 변수를 표시할 수 있습니다.
```shell
$ echo $HOME
```

Microsoft Windows 명령 셸은 다음 명령으로 표시할 수 있는 환경 변수 목록도 유지 관리합니다.
```shell
> set
> echo %USERPROFILE%
```

다음 표는 Linux 환경에서 Windows 환경 변수에 액세스할 수 있는지 여부를 나타냅니다.

### Scope of Environment Variables
> 상위 셸에 대해 정의된 환경 변수는 일반적으로 셸 스크립트를 실행하는 데 사용되는 것과 같은 하위 셸 프로그램에서 상속됩니다.
따라서 쉘 스크립트가 명령 쉘 프롬프트에서 실행될 때 일반적으로 환경 변수를 다시 초기화할 필요가 없습니다.
그러나 실행 중인 셸 스크립트에 추가 구성이 필요한 경우 이러한 구성은 셸 스크립트를 실행하기 전에 로그인 셸에서 수행해야 합니다.

이전에 시작된 다른 명령 셸로 전파되지 않도록 스크립트에 설정된 환경 변수입니다.

예를 들어 로그인 창이 열리고 환경 변수가 설정되면 해당 창에 대해서만 활성화됩니다.

시작 구성 파일에서 환경 변수를 설정하면 열려 있는 모든 창에 대해 해당 변수가 설정됩니다.

### Accessing Windows Environment Variables from Linux
Windows에서 실행되는 Linux 환경은 Windows 환경 변수에 액세스할 수 있습니다. 여기에는 Cygwin 및 Git Bash가 포함됩니다.


## PATH Environment Variable
> `PATH` 환경 변수는 명령 셸 프롬프트에서 프로그램 이름을 입력할 때 프로그램을 찾는 방법을 셸 프로그램에 나타냅니다. `PATH`에 있는 모든 폴더를 검색하여 프로그램 이름을 찾고 찾으면 프로그램을 실행합니다.

`PATH` 환경 변수에 필요한 폴더가 없으면 PATH 환경 변수를 수정하여 폴더를 추가할 수 있습니다. 이것은 일반적으로 `.bash_profile` 또는 `.bashrc` 파일과 같은 셸 시작 파일에서 수행됩니다.

다음과 같은 구문을 사용하여 동일한 프로그램의 시스템 복사본보다 먼저 프로그램을 찾을 수 있도록 경로 시작 부분에 보다 구체적인 폴더를 추가하는 것이 일반적입니다.
```shell
export PATH="/some/folder:${PATH}"
```

또 다른 옵션은 명령줄에서 실행되는 "설정" 셸 스크립트 파일에서 `PATH` 환경 변수를 편집하는 것입니다. 이 방법의 단점은 설정을 구성할 때마다 실행해야 한다는 것입니다.

이 접근 방식의 장점은 구성을 일반 사용자 환경과 분리할 수 있다는 것입니다.

설정 스크립트가 실행될 때마다 `PATH`가 수정되지 않고 결국 `PATH` 길이의 한계에 도달하도록 하려면 다음과 같이 별도의 환경 변수를 설정하고 확인할 수 있습니다.

이것은 쉘이 지속적이고 각 실행 후에 닫히지 않는 경우에만 의미가 있습니다.

```shell
if [ -z "${ABC_SETUP}" ]; then
    # The setup has not been completed so update the PATH
    export PATH="/some/folder:${PATH}"
    # Set the variable to check next time
    export ABC_SETUP="YES"
fi
```

### `PATH` Lookup Optimization using `hash`
명령줄에 명령을 입력할 때마다 PATH 환경 변수를 구문 분석하고 폴더를 검색하려면 컴퓨터 리소스가 필요하고 처리 시간이 걸립니다. 

결과적으로 Linux는 해시 테이블을 사용하여 프로그램과 절대 경로를 추적합니다.

해시 명령은 이 해시 테이블을 관리하는 데 사용되며 해시 테이블에 명령을 나열하는 옵션 없이 실행할 수 있습니다. 

예를 들면 다음과 같습니다.

```shell
$ hash
hits    command
  15    /mingw64/bin/git
   1    /c/WINDOWS/py
  20    /usr/bin/vi
  13    /usr/bin/ls
```

다음은 bash 문서에서 가져온 것입니다.
```
이름이 쉘 함수도 내장 함수도 아니고 슬래시를 포함하지 않는 경우, bash는 PATH의 각 요소에서 해당 이름의 실행 파일이 포함된 디렉토리를 검색합니다. Bash는 해시 테이블을 사용하여 실행 파일의 전체 경로 이름을 기억합니다(아래 SHELL BUILTIN COMMANDS의 해시 참조). PATH에 있는 디렉토리의 전체 검색은 명령이 해시 테이블에 없는 경우에만 수행됩니다. 검색에 실패한 경우, 쉘은 command_not_found_handle이라는 정의된 쉘 함수를 검색합니다. 해당 함수가 존재하면 원래 명령과 원래 명령의 인수를 인수로 사용하여 호출됩니다. 함수의 종료 상태는 쉘의 종료 상태가 됩니다. 해당 함수가 정의되지 않은 경우 쉘은 오류 메시지를 인쇄하고 종료 상태 127을 리턴합니다.
```

새 버전의 프로그램이 설치되어 `PATH`의 다른 위치에 있는 경우 새 위치가 사용되도록 해시를 지워야 할 수 있습니다.
```shell
$ hash -r
```

## File Paths
> Linux 및 Windows의 파일 경로는 절대 경로 또는 상대 경로일 수 있습니다. 여기서 절대 경로에는 루트 폴더의 전체 경로, Linux의 경우 `/`, Windows의 경우 `C:\`가 포함됩니다. 상대 경로는 현재 폴더를 기준으로 하며 폴더 수준 위로 이동하기 위해 `..`를 포함할 수 있습니다.

Linux의 파일 경로는 폴더(디렉토리) 수준에 대해 `/` 구분 기호를 사용하는 반면 Windows는 구분 기호로 `\`를 사용합니다.

파일 및 폴더 이름에 공백이 있으면 프로그램에서 공백이 명령 매개변수 사이의 구분을 나타내는지 여부를 모르기 때문에 문제가 발생할 수 있습니다.
따라서 공백이 포함된 이름은 큰따옴표나 작은따옴표로 묶어야 합니다. Cygwin과 같은 일부 환경에서는 공백 앞에 백슬래시를 삽입하여 공백을 처리할 수 있습니다.

프로그램 이름을 입력할 때마다 공백을 처리할 필요가 없기 때문에 `PATH`를 수정하면 공백이 포함된 소프트웨어 설치 폴더를 간단하게 처리할 수 있습니다.