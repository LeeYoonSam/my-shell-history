# 3. User Environment Basics
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


## PATH Environment Variable


## File Paths

