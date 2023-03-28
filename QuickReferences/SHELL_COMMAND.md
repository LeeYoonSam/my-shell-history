# Shell Commands

## type
> type 명령을 사용하여 명령이 내장된 쉘인지 여부를 알 수 있습니다.

```shell
type read
```

### option
- `-a` 모든 옵션을 보기

```shell
type -a read
```

## exit
> 스크립트 실행을 중지하기 위해 exit 명령을 사용합니다.

- exit 명령어 뒤에 종료 상태를 제공할수 있습니다.
- 일반적으로 스크립트나 프로그램이 성공적으로 실행되면 종료 상태 0을 반환합니다.
- 어떤 이유로든 성공적으로 실행되지 않으면 0이 아닌 종료 상태를 반환합니다.
- 원하는 경우 다양한 종료 상태를 사용할 수 있습니다.

## useradd
```sh
이름
    useradd - 새 사용자를 생성하거나 기본 새 사용자 정보를 업데이트합니다.

개요
    useradd [옵션] 로그인
    사용자 추가 -D
    useradd -D [옵션]

설명
    -D 옵션 없이 호출하면 useradd 명령은 명령줄에 지정된 값과 시스템의 기본값을 사용하여 새 사용자 계정을 만듭니다. 명령줄 옵션에 따라 useradd 명령은 시스템 파일을 업데이트하고 새 사용자의 홈 디렉토리를 만들고 초기 파일을 복사할 수도 있습니다.

    기본적으로 새 사용자에 대한 그룹도 생성됩니다(-g, -N, -U 및 USERGROUPS_ENAB 참조).
```

```sh
[vagrant@localuser ~]$ sudo useradd woz
[vagrant@localuser ~]$ sudo passwd woz
woz 사용자의 비밀 번호 변경 중
새  암호:
잘못된 암호: 암호는 8 개의 문자 보다 짧습니다
새  암호 재입력:
passwd: 모든 인증 토큰이 성공적으로 업데이트 되었습니다.
[vagrant@localuser ~]$ 
[vagrant@localuser ~]$ 
[vagrant@localuser ~]$ su woz
암호:
[woz@localuser vagrant]$ 
```
- useradd 명령을 사용해서 `woz` 유저를 추가
- passwd 를 사용해서 `woz` 비밀번호 변경
- 암호입력시 경고를 무시하고 짧게 지정해도 변경이 가능
- su woz 로 사용자 로그인

## userdel
```sh
이름
    userdel - 사용자 계정 및 관련 파일 삭제

개요
    userdel [옵션] 로그인

설명
    userdel 명령은 사용자 이름 LOGIN을 참조하는 모든 항목을 삭제하여 시스템 계정 파일을 수정합니다. 명명된 사용자가 있어야 합니다.
```

옵션 | 설명
--- | ---
`-f` | force의 약자로 사용자가 로그인되어 있어도 계정을 제거하고 삭제도 합니다.
`-r` | 사용자의 홈 디렉토리를 제거

### Example
```sh
[vagrant@localuser ~]$ tail /etc/passwd
nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
chrony:x:998:996::/var/lib/chrony:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
vboxadd:x:997:1::/var/run/vboxadd:/bin/false
yoonsam:x:1001:1002:Lee Yoon Sam:/home/yoonsam:/bin/bash
albert:x:1002:1003:YoonSam:/home/albert:/bin/bash
lemon:x:1003:1004::/home/lemon:/bin/bash
good:x:1004:1005:hello my name is good:/home/good:/bin/bash

[vagrant@localuser ~]$ id albert
uid=1002(albert) gid=1003(albert) groups=1003(albert)

[vagrant@localuser ~]$ sudo userdel albert
[vagrant@localuser ~]$ id albert
id: albert: no such user

[vagrant@localuser ~]$ ls -l /home
합계 20
drwx------  2    1002    1003 4096 12월 31 02:43 albert
drwx------  2 good    good    4096  1월 14 03:35 good
drwx------  2 lemon   lemon   4096  1월  8 06:57 lemon
drwx------. 3 vagrant vagrant 4096  1월 28 06:54 vagrant
drwx------  2 yoonsam yoonsam 4096 12월 30 02:18 yoonsam
```
- userdel 을 옵션없이 사용하면 사용자는 제거되지만 파일은 남게 됩니다.
- 사용자 파일이 제거된 후에 액세스하려는 경우 유용할 수 있습니다.

```sh
cat /etc/login.defs
#
# Min/max values for automatic uid selection in useradd
#
UID_MIN                  1000
UID_MAX                 60000
# System accounts
SYS_UID_MIN               201
SYS_UID_MAX               999
```
- UID MIN, MAX 
    - 자동 uid 선택 및 사용자 추가에 대한 최소 및 최대 값입니다.
    - 따라서 Linux 시스템에서 첫 번째 사용자를 생성하면 사용자 ID가 1000이 됩니다.
    - 다음에 계정을 추가할 때 숫자가 1씩 증가합니다.
- SYS_UID MIN, MAX
    - 시스템 계정 또는 시스템 계정으로 간주되는 최대 사용자 ID가 999임을 의미합니다.
    - 매우 중요한 계정을 삭제하지 않으려면 먼저 UID를 확인하는 것이 좋습니다.
    - 1000 미만이면 서버에서 필요할 수 있는 서비스를 운영할 수 있으므로 수행 중인 작업에 주의해야 합니다.

```sh
[vagrant@localuser ~]$ tail /etc/passwd
rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
chrony:x:998:996::/var/lib/chrony:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
vboxadd:x:997:1::/var/run/vboxadd:/bin/false
yoonsam:x:1001:1002:Lee Yoon Sam:/home/yoonsam:/bin/bash
lemon:x:1003:1004::/home/lemon:/bin/bash
good:x:1004:1005:hello my name is good:/home/good:/bin/bash

[vagrant@localuser ~]$ sudo userdel -r lemon

[vagrant@localuser ~]$ id -u lemon
id: lemon: no such user

[vagrant@localuser ~]$ ls -l /home/lemon
ls: cannot access /home/lemon: 그런 파일이나 디렉터리가 없습니다
```
- `-r` 옵션은 홈 디렉토리와 그 홈 디렉토리 내에 있던 모든 파일을 제거합니다.


## test
> 조건식을 평가 합니다.<br/>
EXPR 평가에 따라 0(참) 또는 1(거짓) 상태로 종료합니다.<br/>
식은 단항 또는 이항일 수 있습니다.<br/>
단항식은 종종 파일의 상태를 검사하는 데 사용됩니다.<br/>
문자열 연산자와 숫자 비교 연산자도 있습니다.

### File operators
```
-a FILE        True if file exists.
-b FILE        True if file is block special.
-c FILE        True if file is character special.
-d FILE        True if file is a directory.
-e FILE        True if file exists.
-f FILE        True if file exists and is a regular file.
-g FILE        True if file is set-group-id.
-h FILE        True if file is a symbolic link.
-L FILE        True if file is a symbolic link.
-k FILE        True if file has its `sticky' bit set.
-p FILE        True if file is a named pipe.
-r FILE        True if file is readable by you.
-s FILE        True if file exists and is not empty.
-S FILE        True if file is a socket.
-t FD          True if FD is opened on a terminal.
-u FILE        True if the file is set-user-id.
-w FILE        True if the file is writable by you.
-x FILE        True if the file is executable by you.
-O FILE        True if the file is effectively owned by you.
-G FILE        True if the file is effectively owned by your group.
-N FILE        True if the file has been modified since it was last read.
```

### String operators
```
-z STRING      True if string is empty.
-n STRING
    STRING      True if string is not empty.
STRING1 = STRING2
                True if the strings are equal.
STRING1 != STRING2
                True if the strings are not equal.
STRING1 < STRING2
                True if STRING1 sorts before STRING2 lexicographically.
STRING1 > STRING2
                True if STRING1 sorts after STRING2 lexicographically.
```

### Other operators
```
-o OPTION      True if the shell option OPTION is enabled.
-v VAR	 True if the shell variable VAR is set
! EXPR         True if expr is false.
EXPR1 -a EXPR2 True if both expr1 AND expr2 are true.
EXPR1 -o EXPR2 True if either expr1 OR expr2 is true.

arg1 OP arg2   Arithmetic tests.  OP is one of -eq, -ne,
                -lt, -le, -gt, or -ge.
```

## $()
> 명령의 출력을 캡처하는 데 사용됩니다.

```shell
USER_NAME=$(id -un)
```
- 명령의 출력을 보내고 `USER_NAME` 변수에 저장

## Arguments - ${}
- All args count: ${#}
- All args: ${@}
- First arg: ${1}
- Second arg: ${2}
- Third arg: ${3}

## ${?}
> Barish는 설정하는 몇 가지 특수 변수가 있으며 이러한 특수 변수 중 하나는 `${?}` 입니다.

- 가장 최근에 실행된 명령의 종료 상태를 보유합니다.

## `=` or `==`

`if [[ left = right ]]`
- left 와 right 를 비교하는 것
- 정확히 일치하는 항목을 찾을때 하나의 등호만 사용합니다.

`if [[ left == right ]]`
- right 연산자를 패턴으로 사용하여 패턴 매칭을 수행합니다.

## help `command`

```shell
help read | less
```
- read 명령에 대해 요약해서 설명

## read
> 표준 입력에서 한 줄을 읽고 필드로 분할합니다.

표준 입력 또는 -u 옵션이 제공된 경우 파일 설명자 FD에서 한 줄을 읽습니다.<br/>
행은 단어 분할과 같이 필드로 분할되며 첫 번째 단어는 첫 번째 NAME에 할당되고 두 번째 단어는 두 번째 NAME에 할당되는 식으로 나머지 단어는 마지막 NAME에 할당됩니다.<br/>
`$IFS`에 있는 문자만 단어 구분 기호로 인식됩니다.

**참고**
- 전체 입력 라인을 하나의 변수에 할당하려면 하나의 이름 또는 하나의 변수만 제공

### options
- `[name ...]` 를 사용해서 이름을 여러개 지정할 수 있습니다.
- `-p` prompt - 읽기를 시도하기 전에 후행 개행 없이 문자열 PROMPT를 출력합니다.

```shell
[vagrant@localhost vagrant]$ read -p 'Type something: ' THING
>>> Type something: something
[vagrant@localhost vagrant]$ echo ${THING}
>>> something
```

### 입력 및 출력 세 가지 기본 유형
1. 표준 입력
2. 표준 출력
3. 표준 오류

표준 입력은 키보드에서 나오고 표준 출력과 표준 오류는 화면에 표시됩니다.

## useradd
> 새 사용자 생성 또는 기본 새 사용자 정보 업데이트

- 일반적으로 규칙에 따라 8자 이하입니다.
- 엄격한 규칙이 아니지만 일반적으로 따라야 할 관습이나 관행입니다.
- 시스템에 사용자를 추가하려면 슈퍼 사용자 권한을 사용해야 합니다.
- 대문자를 사용할 수 있지만 관례상 모두 소문자입니다.
- 특수 문자를 포함할 수 없다는 것입니다.

### options
- `-m` 사용자의 홈 디렉토리가 존재하지 않는 경우 생성합니다. 또한 스켈레톤 디렉토리에 포함된 파일과 디렉토리가 복사 됩니다.
    - `-k` 옵션을 계속 사용하여 해당 기본값을 재정의할 수 있습니다.

## passwd
> 사용자의 인증 토큰 업데이트

`echo` 를 파이프해서 `passwd --stdin` 명령에 프로그래밍 방식으로 비밀번호를 제공
```shell
# Set the password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
```

`-e` 옵션과 함께 비밀번호를 사용하여 계정의 비밀번호를 강제로 재설정
```shell
# Force password change on first login.
passwd -e ${USER_NAME}
```

### options
- `-e` expire - 이것은 계정의 암호를 만료시키는 빠른 방법입니다. 사용자는 다음에 로그인을 시도할 때 암호를 변경해야 합니다. `root` 만 사용 가능합니다.

## date +%s(format) 

### 시스템 날짜 및 시간 인쇄 또는 설정
format 형식에 맞게 date 를 전살

```sh
date +%s
```

## sha256sum
> SHA256(256비트) 체크섬을 인쇄하거나 확인합니다. FILE이 없거나 FILE이 -이면 표준 입력을 읽습니다.

```sh
date +%s | sha256sum
7858e7b348685f6291540b93fdeb68bad357349f9a567e71296ae1ba114e4827
```

## head
> 각 FILE의 처음 10줄을 표준 출력으로 인쇄합니다.

### opstions

```sh
head -n1 `file`
```
-  파일의 라인을 n 만큼 출력


```sh
echo "testing" | head -c2
>> te
```
- c2 의 숫자만큼만 자르기


## !(문자열)
> command 의 마지막 명령 실행

```sh
!vi
```
- 최근에 실행한 vi 로 시작하는 명령 실행

## shuf
> 무작위 순열 생성

- 입력 행의 임의 순열을 표준 출력에 씁니다.

```sh
shuf /etc/password
cat /etc/password
```

## fold
> 지정된 너비에 맞게 각 입력 줄을 래핑합니다.

```sh
S='!@#$%^&*()_-+='
echo "${S}" | fold -w1 | shuf
```
- w숫자 만큼 라인 래핑 후 `shuf`로 순서 섞기

```출력
+
-
*
%
!
@
)
$
&
(
=
#
_
^
```

## bash
> GNU Bourne-Again SHell<br/>
Bash는 표준 입력 또는 파일에서 읽은 명령을 실행하는 sh 호환 명령 언어 해석기입니다. Bash는 또한 Korn 및 C 셸(ksh 및 csh)의 유용한 기능을 통합합니다.<br/>
Bash는 IEEE POSIX 사양(IEEE 표준 1003.1)의 Shell 및 Utilities 부분을 준수하도록 구현되었습니다. Bash는 기본적으로 POSIX를 준수하도록 구성할 수 있습니다.

### 쉘 문법
Shell GRAMMAR | explanation
--- | ---
PATH | 명령의 검색 경로입니다. 쉘이 명령을 찾는 콜론으로 구분된 디렉토리 목록입니다(아래 COMMAND EXECUTION 참조). PATH 값의 길이가 0인(null) 디렉토리 이름은 현재 디렉토리를 나타냅니다. Null 디렉터리 이름은 두 개의 인접한 콜론 또는 초기 또는 후행 콜론으로 나타날 수 있습니다. 기본 경로는 시스템에 따라 다르며 bash를 설치하는 관리자가 설정합니다. 일반적인 값은 ``/usr/gnu/bin:/usr/local/bin:/usr/ucb:/bin:/usr/bin''입니다.

```sh
echo ${PATH}
>>> /usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/sbin:/home/vagrant/bin
```

### Bash Special Parameters
> 쉘은 여러 매개변수를 특별히 취급합니다. 이러한 매개변수는 참조만 가능하고 할당할 수 없습니다.

Special Parameters | explanation
--- | ---
`*` | 1부터 시작하여 위치 매개변수로 확장합니다. 큰따옴표 안에 확장이 발생하면 IFS 특수 변수의 첫 번째 문자로 구분된 각 매개변수 값이 있는 단일 단어로 확장됩니다. 즉, "$*"는 "$1c$2c..."와 동일하며, 여기서 c는 IFS 변수 값의 첫 번째 문자입니다. IFS가 설정되지 않은 경우 매개변수는 공백으로 구분됩니다. IFS가 null인 경우 중간 구분 기호 없이 매개 변수가 결합됩니다.     
`@` | 1부터 시작하여 위치 매개변수로 확장합니다. 큰따옴표 안에 확장이 발생하면 각 매개변수가 별도의 단어로 확장됩니다. 즉, "$@"는 "$1" "$2"와 동일합니다. 단어 내에서 큰따옴표 확장이 발생하면 첫 번째 매개변수의 확장이 원래 단어의 시작 부분과 결합되고 확장이 마지막 매개변수는 원래 단어의 마지막 부분과 연결됩니다. 위치 매개변수가 없으면 "$@" 및 $@는 아무것도 확장되지 않습니다(즉, 제거됨).
`#` | 10진수 위치 매개변수의 수로 확장됩니다.
`?` | 가장 최근에 실행된 포그라운드 파이프라인의 종료 상태로 확장됩니다.
`-` | set 내장 명령 또는 쉘 자체에 의해 설정된 플래그(예: -i 옵션)에 의해 호출 시 지정된 현재 옵션 플래그로 확장됩니다.
`$` | 쉘의 프로세스 ID로 확장됩니다. () 서브쉘에서는 서브쉘이 아닌 현재 쉘의 프로세스 ID로 확장됩니다.
`!` | 가장 최근에 실행된 백그라운드(비동기) 명령의 프로세스 ID로 확장됩니다.
`0` | 쉘 또는 쉘 스크립트의 이름으로 확장됩니다. 이것은 쉘 초기화에서 설정됩니다. 명령 파일로 bash를 호출하면 $0이 해당 파일의 이름으로 설정됩니다. bash가 -c 옵션으로 시작되면 $0은 실행될 문자열 다음의 첫 번째 인수(있는 경우)로 설정됩니다. 그렇지 않으면 인수 0으로 지정된 대로 bash를 호출하는 데 사용되는 파일 이름으로 설정됩니다.
`_` | 셸 시작 시 환경 또는 인수 목록에서 전달된 대로 실행 중인 셸 또는 셸 스크립트를 호출하는 데 사용되는 절대 경로 이름으로 설정합니다. 결과적으로 확장 후 이전 명령에 대한 마지막 인수로 확장됩니다. 또한 실행된 각 명령을 호출하는 데 사용되는 전체 경로 이름으로 설정하고 해당 명령으로 내보낸 환경에 배치합니다. 메일을 확인할 때 이 매개변수는 현재 확인 중인 메일 파일의 이름을 보유합니다.

## man [command]
> command 의 매뉴얼

- /string 으로 단어 검색 가능


## basename - 파일관리
> 파일 이름에서 디렉토리 및 접미사 제거

```sh
basename /vagrant/luser-demo06.sh 
>> luser-demo06.sh
```
- 기본 이름을 제공할 수 있도록 전달된 문자열의 디렉토리 부분을 제거합니다.

## dirname - 파일관리
> 파일 이름에서 마지막 구성 요소 제거

```sh
dirname /vagrant/luser-demo06.sh
>> /vagrant
```
- 존재하지 않는 경로를 지정할 수 있으며 디렉토리처럼 보이는 부분을 반환합니다.

## help [command] | head
> command 에 대한 도움말에서 헤더만 표시

```sh
help for | head

>>
for: for NAME [in WORDS ... ] ; do COMMANDS; done
    Execute commands for each member in a list.
    
    The `for' loop executes a sequence of commands for each member in a
    list of items.  If `in WORDS ...;' is not present, then `in "$@"' is
    assumed.  For each element in WORDS, NAME is set to that element, and
    the COMMANDS are executed.
    
    Exit Status:
    Returns the status of the last command executed.
```

### grep - 문자열 출력
> 리눅스에서 `grep` 명령어는 특정 파일에서 지정한 문자열이나 정규표현식을 포함한 행을 출력해주는 명령어입니다. <br/>
> 특히 `tail`이나 `ls` 등 다양한 명령어와 조합하여 응용되는 경우가 많아서 이 `grep`명령어는 리눅스에서 능숙하게 사용할 줄 알아야 하는 기본 명령어입니다.

```shell
grep [옵션][패턴][파일명]
```
```sh
이름
    grep, egrep, fgrep - 패턴과 일치하는 줄 인쇄

개요
    grep [OPTIONS] PATTERN [FILE...]
    grep [OPTIONS] [-e PATTERN | -f FILE] [FILE...]

설명
    grep은 지정된 PATTERN과 일치하는 행을 찾기 위해 명명된 입력 파일(또는 파일이 명명되지 않았거나 단일 하이픈 빼기(-)가 파일 이름으로 제공된 경우 표준 입력)을 검색합니다. 기본적으로 grep은 일치하는 행을 인쇄합니다.

    또한 egrep 및 fgrep의 두 가지 변형 프로그램을 사용할 수 있습니다. egrep은 grep -E와 동일합니다. fgrep은 grep -F와 같습니다.
    egrep 또는 fgrep으로 직접 호출하는 것은 더 이상 사용되지 않지만 이를 사용하는 기록 애플리케이션이 수정되지 않은 상태로 실행될 수 있도록 제공됩니다.
```

### Option
| Option | Description | 
| --- | --- | 
| -c | 일치하는 행의 수를 출력한다. |
| -i | 대소문자를 구별하지 않는다. |
| -v | 일치하지 않는 행만 출력한다. |
| -n | 포함된 행의 번호를 함께 출력한다. |
| -l | 패턴이 포함된 파일의 이름을 출력한다. |
| -w | 단어와 일치하는 행만 출력한다. |
| -x | 라인과 일치하는 행만 출력한다. |
| -r | 하위 디렉토리를 포함한 모든 파일에서 검색한다. |
| -m 숫자 | 최대로 표시될 수 있는 결과를 제한한다. |
| -E | 찾을 패턴을 정규 표현식으로 찾는다. |
| -F | 찾을 패턴을 문자열로 찾는다. |

### Example

**문자열로 찾기**
```shell
# 특정 파일에서 'error' 문자열 찾기
grep 'error' 파일명

# 여러개의 파일에서 'error' 문자열 찾기
grep 'error' 파일명1 파일명2

# 현재 디렉토리내에 있는 모든 파일에서 'error' 문자열 찾기
grep 'error' *

# 특정 확장자를 가진 모든 파일에서 'error' 문자열 찾기
grep 'error' *.log
```
- grep명령어를 사용하시면 특정 파일에서 내가 원하는 문자열이 있는 라인을 찾을 수 있습니다.

**정규표현식으로 찾기**
```shell
# 특정 파일에서 문자열이 포함된 행을 찾는다.
grep '^[ab]' 파일명 

# 특정 파일에서 a로 시작하는 모든 단어를 찾는다.
grep 'a*' 파일명 

# 특정 파일에서 a로 시작하고 z로 끝나는 5자리 단어를 찾는다.
grep 'a...z' 파일명 

# 특정 파일에서 a,b,c로 시작하는 단어를 모두 찾는다.
grep [a-c] 파일명

# 특정 파일에서 apple 또는 Apple로 시작하는 단어를 모두 찾는다.
grep [aA]pple 파일명 

# 특정 파일에서 a나 b로 시작되는 모든 행을 찾는다.
grep '^[ab]' 파일명 

# 특정 파일에서 apple로 시작되고 0나 9의 숫자로 끝나로 시작되는 모든 행을 찾는다.
grep 'apple'[0-9] 파일명
```

**실시간 로그 보기 (tail + grep)**
```shell
tail -f mylog.log | grep 192.168.15.86
```
- `grep`은 다른 명령어와 조합해서 사용하는 경우도 많습니다. 대부분 개발자들이 실시간 로그 체크를 할 때는 tail과 grep 명령어 조합으로 로그파일에서 자신이 원하는 키워드만 추출하고는 합니다. 위의 명령어대로 사용하시면 mylog파일을 실시간으로 액세스하고 IP주소가 192.168.49.16인 행만 추출할 수 있겠습니다.

**특정 파일에서 여러개 문자열 찾기**
```shell
cat mylog.txt | grep 'Apple' | grep 'Banana'
```
- | 파이프를 사용하면 `grep`명령어를 여러 개 사용하여 특정 파일에서 여러 개의 문자열을 찾을 수 있을 수도 있습니다. 위의 명령어대로 입력한다면 mylog.txt 파일에서 Apple과 Banana이 있는 문자열들을 찾을 수 있겠습니다.

**grep 한 결과 값 txt 파일로 저장하기**
```shell
grep -n 'Apple' mylog.txt > result.txt
```
- grep한 결과가 길면 터미널에서 확인이 어렵기 때문에 txt파일로 저장하여 확인하고는 합니다. 위의 명령어대로 입력한다면 mylog.txt 파일에서 Apple이 있는 문자열들을 result.txt 파일에 저장하실 수 있습니다.

## for 커맨드에서 사용하기 - loop
```sh
for X in Frank Claire Doug
> do
>   echo "Hi ${X}."
> done
Hi Frank.
Hi Claire.
Hi Doug.
```

`;` 을 사용해서 한줄로 처리
```sh
 for X in Frank Claire Doug; do   echo "Hi ${X}."; done
Hi Frank.
Hi Claire.
Hi Doug.
```

## sleep
>  단순히 지정된 시간 동안 실행을 지연시킵니다.<br/>
`sleep` 다음에 숫자와 접미사를 사용할 수 있으며 해당 접미사는 4초 및 4분, 4시간, 4일 일 수 있습니다.

```sh
while [[ true ]]
> do
> echo "${RANDOM}"
> sleep 1
> done

>> 2771
>> 20328
>> 29428
>> .
>> .
>> .
```
- `Ctrl + C`는 명령에 인터럽트 신호를 보내 중단시킵니다.

## shift - 문자열 조작
> 위치 매개변수를 이동합니다.

위치 매개변수 $N+1,$N+2 ...를 $1,$2 ...로 이름을 변경합니다. N이 지정되지 않으면 1로 간주됩니다.

종료 상태: N이 음수이거나 $#보다 크지 않으면 성공을 반환합니다.

## cut - 문자열 조작
> cut 명령어는 file 이나 표준 입력에서 받은 문자열을 잘라내서 새로운 문자열을 만드는 명령어입니다.  

```sh
type -a cut
cut is /usr/bin/cut
```

파일 인수가 지정되지 않았거나 파일 인수가 단일 대시(`-`)인 경우 `cut`은 표준 입력에서 읽습니다. 

목록으로 지정된 항목은 열 위치 또는 특수 문자로 구분된 필드와 관련될 수 있습니다. 

열 및 필드 번호 매기기는 1부터 시작합니다.

### Option
| Option | Description | 
| --- | --- | 
| `-b`, --bytes | 바이트를 기준으로 잘라냅니다. |
| `-c`, --characters | 문자열을 기준으로 잘라냅니다. |
| `-d`, --delimiter |	지정한 문자를 구분자로 사용합니다. (기본 TAB) |
| `-f`, --fields	| 필드를 기준으로 잘라냅니다.	|
| `-z`, --zero-terminated |	라인의 구분자를 개행문자가 아닌 NUL 을 사용합니다. |

### Example
```sh
cut -c 1 /etc/passwd
r
b
d
a
l
s
...
```
- passwd 에 있는 내용의 첫번째 글자만 추출

```sh
cut -c 1-4 /etc/passwd
root
bin:
daem
adm:
lp:x
sync
...
```
- 1-4 번째 글자만 추출

```sh
cut -c 4- /etc/passwd
t:x:0:0:root:/root:/bin/bash
:x:1:1:bin:/bin:/sbin/nologin
mon:x:2:2:daemon:/sbin:/sbin/nologin
:x:3:4:adm:/var/adm:/sbin/nologin
x:4:7:lp:/var/spool/lpd:/sbin/nologin
c:x:5:0:sync:/sbin:/bin/sync
...
```
- 4번째 이후 글자모두 추출

```sh
cut -c -4 /etc/passwd
root
bin:
daem
adm:
lp:x
sync
...
```
- 4번째 이전 글자까지 추출

쉼표로 구분하여 여러 개별 문자를 선택할 수 있습니다.
```sh
cut -c 1,3,5 /etc/passwd
ro:
bnx
deo
amx
l::
sn:
```
- 첫 번째, 세 번째 및 다섯 번째 문자를 인쇄 합니다.
- `5,3,1` | `3,1,5` 등 순서가 변경되어도 동일하게 출력 합니다.

### 범위를 사용하는 방법
문자를 자르기 위해 `-c` 옵션을 사용했지만 `-b` 옵션을 사용해서 `/etc/passwd` 파일에 있는 모든 줄의 첫 번째 바이트를 표시하기 위해 바이트 단위로 잘라냅니다.
```sh
cut -b 1 /etc/passwd
r
b
d
a
l
s
...
```
- `cut -c 1 /etc/passwd` 와 같은 결과 입니다.

**멀티 바이트**
예를 들어 UTF 8 문자는 다중 바이트 문자입니다.
```
[vagrant@localuser vagrant]$ echo "한글" | cut -c 1
한
[vagrant@localuser vagrant]$ echo "한글" | cut -b 1
?
```
- c, b 옵션에 대한 값이 달라졌습니다.

기본적으로 필드별로 줄을자를 수 있습니다.

`-f`는 탭에서 분할 합니다.

탭 앞에 있는 모든 항목은 첫 번째 필드로 간주됩니다.

첫 번째 탭 뒤와 두 번째 탭 앞의 모든 항목은 두 번째 필드로 간주되는 식입니다.

`cut`은 필드라는 용어를 사용하지만 원하는 경우 이를 열로 생각할 수 있습니다.

echo 명령을 사용하여 일부 탭과 ​​제한된 데이터를 생성하겠습니다.

`echo`에 대한 `-e` 옵션을 사용하면 탭, 문자, 새 줄 생성 등과 같은 일부 작업을 수행할 수 있는 일부 백슬래시 이스케이프를 사용할 수 있습니다.

```sh
[vagrant@localuser vagrant]$ echo -e 'one\ttwo\tthree'
one	two	three
[vagrant@localuser vagrant]$ echo -e 'one\ttwo\tthree' | cut -f 1
one
[vagrant@localuser vagrant]$ echo -e 'one\ttwo\tthree' | cut -f 2
two
[vagrant@localuser vagrant]$ echo -e 'one\ttwo\tthree' | cut -f 3
three
```

탭으로 구분되지 않은 데이터가 있는 경우 어떻게 됩니까?

CSV 또는 쉼표로 구분된 값 파일을 다루고 있다고 가정해 보겠습니다.

```sh
[vagrant@localuser vagrant]$ echo 'one,two,three' | cut -d ',' -f 3
three
[vagrant@localuser vagrant]$ echo 'one,two,three' | cut -d ',' -f 2
two
[vagrant@localuser vagrant]$ echo 'one,two,three' | cut -d ',' -f 1
one

[vagrant@localuser vagrant]$ echo 'one,two,three' | cut -d , -f 1
one
```
- `-d` 옵션에서 구분자에 따옴표 없이 입력이 가능합니다.

```sh
[vagrant@localuser vagrant]$ echo 'one\two\three' | cut -d \ -f 1
cut: 구획 문자는 단일 문자여야 합니다
Try 'cut --help' for more information.
```
- 특수 문자를 그대로 사용하면 동작하지 않습니다.

```sh
[vagrant@localuser vagrant]$ echo 'one\two\three' | cut -d '\' -f 1
one
[vagrant@localuser vagrant]$ echo 'one\two\three' | cut -d \\ -f 1
one
```
- 이러한 경우를 대비해서 항상 '' 를 사용하는것을 추천 합니다.
- 기호 앞에 `\` 를 한번 더 써주면 인식을 합니다.

```sh
[vagrant@localuser vagrant]$ cut -d ':' -f 1,3 /etc/passwd
root:0
bin:1
daemon:2
adm:3
lp:4
sync:5
```
- `/etc/passwd` 출력을 `:` 로 구분하고 그 결과의 1,3번째 를 출력 합니다.
- ex) `root:x:0:0:root:/root:/bin/bash` -> 1-root, 2-x, 3-0, 4-0, 5-root, 6-/root...

### CSV 샘플 테스트
```sh
[vagrant@localuser vagrant]$ echo 'first, last' > people.csv
[vagrant@localuser vagrant]$ echo 'John, Smitt' >> people.csv
[vagrant@localuser vagrant]$ echo 'firstly, mclasty' >> people.csv
[vagrant@localuser vagrant]$ echo 'Mr. firstly,mclasty' >> people.csv

[vagrant@localuser vagrant]$ cat people.csv
first, last
John, Smitt
firstly, mclasty
Mr. firstly,mclasty

[vagrant@localuser vagrant]$ cut -d ',' -f 1 people.csv
first
John
firstly
Mr. firstly
```

첫 번째는 잘라낼 데이터를 보내기 전에 헤더를 제거하거나 잘라낸 후 제거하는 것입니다.
```sh
[vagrant@localuser vagrant]$ grep first people.csv
first, last
firstly, mclasty
Mr. firstly,mclasty
```
헤더만 일치하도록 검색 범위를 좁히겠습니다.

정규 표현식에 대해 더 이상 배우지 않는다면 최소한 이 두 가지 매우 중요한 정규 표현식을 마음대로 사용할 수 있을 것입니다.

첫 번째 정규식은 `^(carrot)` 기호입니다.
- 줄의 시작 부분과 일치합니다.
- 문자가 아닌 위치와 일치합니다.

따라서 처음으로 시작하는 모든 줄을 일치시키려면 이렇게 `^(carrot)`을 먼저 사용하십시오.
```sh
[vagrant@localuser vagrant]$ grep '^first' people.csv
first, last
firstly, mclasty
```
- 올바른 문자를 사용하지 않으면 반환되는 결과가 달라집니다.

두 번째 정규식은 `$(달러)` 기호입니다.
- 문자가 아닌 위치인 두 개의 일치 항목에서 줄의 끝과 일치합니다.

따라서 T로 끝나는 줄을 모두 찾으려면 이 grep t 달러 기호를 사용할 수 있습니다.
```sh
[vagrant@localuser vagrant]$ grep 't$' people.csv
first, last
John, Smitt
```

이제 우리는 파일의 헤더를 분리했지만 운 좋게도 `grep`에 일치를 반전시키는 편리한 옵션이 있다는 점을 제외하고는 모든 것이 필요합니다.

```sh
[vagrant@localuser vagrant]$ grep -v '^first, last$' people.csv
John, Smitt
firstly, mclasty
Mr. firstly,mclasty
```
- `first` 로 시작하고 `last` 로 끝나지 않는것
- `-v` 옵션을 사용하면 그립이 제공된 패턴과 일치하지 않는 선을 표시합니다.

```sh
[vagrant@localuser vagrant]$ grep -v '^first, last$' people.csv | cut -d ',' -f 1
John
firstly
Mr. firstly
```

나는 cut이 출력을 먼저 변경하고 헤더도 변경하기 때문에 이것을 그다지 좋아하지 않습니다.
그러나 우리가 이것을 할 수 있도록 작동합니다.
```sh
[vagrant@localuser vagrant]$ cut -d ',' -f 1 people.csv
first
John
firstly
Mr. firstly
```
그것이 우리가 헤더를 포함하는 것을 얻는 것입니다.

```sh
[vagrant@localuser vagrant]$ cut -d ',' -f 1 people.csv | grep -v '^first$'
John
firstly
Mr. firstly
```
- 헤더를 제거하고 `cut`은 단일 문자만 처리합니다.


### 번외
```sh
echo X=45 | cut -d = -f 1
> X

echo X=45 | cut -d = -f 2
> 45
```
- X=45 를 `cut -d =` 하면 `=` 를 구분자로 자릅니다. 그러므로 `-f 1` = X, `-f 2` = 45 가 됩니다.
- `=` 를 구분자로 앞뒤를 자르면 2개가 나오기때문에 `-f 3` 을하면 아무런 값도 출력이 되지 않습니다.

```sh
cut -d : -f 1,7 /etc/passwd
```
- 시스템 passwd(5) 파일에서 `name:shell` 쌍으로 사용자의 로그인 이름과 쉘을 추출합니다.

```sh
who | cut -c 1-16,26-38
```
- 현재 로그인한 사용자의 이름과 로그인 시간을 표시합니다.


## function - 함수

쉘 함수를 정의합니다.

```sh
function: function name { COMMANDS ; } or name () { COMMANDS ; }
```

이름이 NAME인 셸 함수를 만듭니다. 간단한 명령으로 호출되면 NAME은 호출하는 셸의 컨텍스트에서 COMMAND를 실행합니다. NAME이 호출되면 인수는 $1...$n으로 함수에 전달되고 함수의 이름은 $FUNCNAME에 있습니다.

## logger - 로그
> logger [options] [message]

- 시스템 로그에 항목을 만듭니다. 
- syslog(3) 시스템 로그 모듈에 대한 쉘 명령 인터페이스를 제공합니다.
- 주로 로거에게 메시지를 제공하면 해당 메시지는 기본적으로 시스템 로그에 기록됩니다.
- 메시지는 `var/log/messages` 파일로 이동합니다.

```sh
type -a logger
logger is /usr/bin/logger
```
- logger는 실행 파일이므로 man을 실행하여 특정 정보를 얻을 수 있습니다.

### Example
```sh
logger 'Hello from the command line!'
sudo tail /var/log/messages

>> Jan 18 21:01:01 localuser systemd: Removed slice User Slice of root.
>> Jan 18 21:01:01 localuser systemd: Stopping User Slice of root.
>> Jan 18 22:00:54 localuser vagrant: Hello from the command line!
>> Jan 18 22:01:01 localuser systemd: Created slice User Slice of root.
>> Jan 18 22:01:01 localuser systemd: Starting User Slice of root.
>> Jan 18 22:01:01 localuser systemd: Started Session 5 of user root.
>> Jan 18 22:01:01 localuser systemd: Starting Session 5 of user root.
>> Jan 18 22:01:02 localuser systemd: Removed slice User Slice of root.
>> Jan 18 22:01:02 localuser systemd: Stopping User Slice of root.
>> Jan 18 22:01:48 localuser vagrant: Hello from the command line!
```
- 태그를 사용하지 않았기 때문에 username 기본으로 표시

**태그(-t) 사용**
```sh
logger -t my-script 'Tagging on.'
sudo tail /var/log/messages

>> Jan 18 21:01:01 localuser systemd: Stopping User Slice of root.
>> Jan 18 22:00:54 localuser vagrant: Hello from the command line!
>> Jan 18 22:01:01 localuser systemd: Created slice User Slice of root.
>> Jan 18 22:01:01 localuser systemd: Starting User Slice of root.
>> Jan 18 22:01:01 localuser systemd: Started Session 5 of user root.
>> Jan 18 22:01:01 localuser systemd: Starting Session 5 of user root.
>> Jan 18 22:01:02 localuser systemd: Removed slice User Slice of root.
>> Jan 18 22:01:02 localuser systemd: Stopping User Slice of root.
>> Jan 18 22:01:48 localuser vagrant: Hello from the command line!
>> Jan 18 22:05:47 localuser my-script: Tagging on.
```

## let - 계산

산술식을 평가합니다.

각 `ARG`를 산술식으로 평가합니다. 

0으로 나누기가 트랩되고 오류로 표시되지만 오버플로 검사 없이 고정 너비 정수에서 평가가 수행됩니다. 

다음 연산자 목록은 동등 우선 순위 연산자 수준으로 그룹화됩니다. 

수준은 내림차순으로 나열됩니다.

이 let 구문은 이중 괄호를 사용하는 것과 거의 같은 역할을 합니다.
```sh
let NUM='2+3'
echo $NUM
> 5

let NUM++
echo $NUM
> 6
```

## EXPR - 계산
EXPR 명령은 주어진 표현식을 처리한 다음 그 결과를 표준 출력으로 보냅니다.

```sh
type -a expr
expr is /usr/bin/expr
```

```sh
expr 1+1
> 1+1

expr 1 + 1
> 2
```
- 연산자 사이에 공백을 넣어야 정확한 계산 결과가 나옵니다.

할당을 수행하기 위해 다른 명령과 마찬가지로 명령 대체를 사용합니다.
```sh
NUM=$(expr 2 + 3)
echo $NUM
> 5
```

## `!!`
- 가장 최근에 실행한 명령을 실행

```sh
locate .bashrc
> /etc/skel/.bashrc
> /home/vagrant/.bashrc

!!
locate .bashrc
> /etc/skel/.bashrc
> /home/vagrant/.bashrc
```
- `locate .bashrc` 를 실행 후 다시 `!!`를 실행하면 `locate .bashrc` 명령이 다시 실행됩니다.


루트 권한으로 가장 최근 명령을 실행하려면 이렇게 사용하면 됩니다.
```sh
sudo !!
sudo locate .bashrc
>
/etc/skel/.bashrc
/home/albert/.bashrc
/home/good/.bashrc
/home/lemon/.bashrc
/home/vagrant/.bashrc
/home/yoonsam/.bashrc
/root/.bashrc
```
- `sudo` 와 함게 `!!`를 실행하면 `sudo locate .bashrc` 명령으로 sudo + 최근 명령이 실행됩니다.

## `! + 글자`
- 실행한 명령중 `글자`로 시작하는 명령을 다시 실행

```sh
locate .bashrc
> /etc/skel/.bashrc
> /home/vagrant/.bashrc

!l
locate .bashrc
> /etc/skel/.bashrc
> /home/vagrant/.bashrc
```

## `$!`
이전 명령줄의 맨 마지막 인수를 사용합니다.

```sh
[vagrant@localuser restore]$ echo 'hello' > catvideos/darthpaw.mp4 
[vagrant@localuser restore]$ cat !$
cat catvideos/darthpaw.mp4
hello
```

## tar - 파일 압축

```sh
type -a tar
tar is /usr/bin/tar
```

```sh
EXAMPLES
    tar -cf archive.tar foo bar
        # 파일 foo와 bar에서 archive.tar를 만듭니다.

    tar -tvf archive.tar
        # archive.tar에 있는 모든 파일을 자세히 나열합니다.

    tar -xf archive.tar
        # archive.tar에서 모든 파일을 추출합니다.
```

**gzip 압축**
```sh
gzip catvideos.tar

> catvideos.tar.gz
```
- `gzip` 명령은 원본 파일을 압축하고 **.gz**를 추가합니다.
- `tar.gz`로 끝나는 파일이 보이면 압축된 아카이브입니다.

**압축 해제**
```sh
gunzip catvideos.tar.zg
```
- gzip 압축 해제 명령
- catvideos.tar 로 복구 됩니다.

**tar 옵션으로 gzip 압축**
```sh
tar -zcvf catvideos.tar.gz catvideos/
```
- tar -z 옵션을 사용해서 gzip 으로 바로 압축 할수 있습니다.

```sh
tar -zcvf catvideos.tgz catvideos/
```
- tar.gz 를 tgz 로 사용

```sh
tar -zxvf /home/vagrant/catvideos.tgz
```
- tgz 파일 압축 해제

## chage - 유저 계정

```sh
이름
    chage - 사용자 비밀번호 만료 정보 변경

개요
    변경 [옵션] LOGIN

설명
    chage 명령은 암호 변경과 마지막 암호 변경 날짜 사이의 일 수를 변경합니다. 이 정보는 시스템에서 사용자가 암호를  변경해야 하는 시기를 결정하는 데 사용됩니다.
```

### 옵션
옵션 | 설명
--- | ---
`-E` | 1970년 1월 1일 이후 사용자 계정에 더 이상 액세스할 수 없는 날짜 또는 일수를 설정합니다.<br/> 날짜는 YYYY-MM-DD 형식(또는 해당 지역에서 더 일반적으로 사용되는 형식)으로 표시될 수도 있습니다. 계정이 잠긴 사용자는 시스템을 다시 사용하기 전에 시스템 관리자에게 문의해야 합니다.<br/>EXPIRE_DATE로 숫자 -1을 전달하면 계정 만료 날짜가 제거됩니다.

---

## awk - 문자열 조작

### Option
Option | Description
--- | ---
`-F fs` | 필드 구분자 fs, 입력 필드 구분 기호(FS 사전 정의 변수의 값)에 fs를 사용합니다.

### Example
```sh
[vagrant@localuser vagrant]$ echo 'L1C1          L1C2' > lines
[vagrant@localuser vagrant]$ echo '    L2C1 L2C2     ' >> lines
[vagrant@localuser vagrant]$ echo '   L3C1      L3C2' >> lines
[vagrant@localuser vagrant]$ echo -e 'L4C1\tL4C2' >> lines
[vagrant@localuser vagrant]$ cat lines
L1C1          L1C2
    L2C1 L2C2     
   L3C1      L3C2
L4C1	L4C2
```
- 여기에 실제로 있는 파일은 4줄이 있는 파일이고 각 줄은 다양한 길이의 공백으로 구분된 두 개의 열로 구성되어 있습니다. 공백은 공백 및/또는 탭입니다.

단일 문자로만 분할할 수 있기 때문에 cut으로 이 데이터를 이해하는 것은 정말 어려울 것입니다.

공간을 분할하더라도 행마다 열을 구분하는 공간의 수가 다르기 때문에 원하는 결과를 얻지 못할 것입니다.
또한 탭이 있는 줄을 처리하지 않습니다.

그러나 `awk`에서는 모든 것이 정말 잘 수행됩니다.
```sh
[vagrant@localuser vagrant]$ awk '{print $1, $2}' lines
L1C1 L1C2
L2C1 L2C2
L3C1 L3C2
L4C1 L4C2
```
- 기본적으로 `awk`의 필드 구분 기호는 공백이거나 다른 방법이 더 정확할 수 있습니다.
- `awk`는 공백이 아닌 문자를 기본적으로 필드로 간주합니다.

예를 들어 `awk`는 각 줄의 시작과 끝에서 불필요한 공백을 쉽게 처리합니다.

### `awk` 활용 사례
- 둘 이상의 문자로 구성된 구분 기호를 사용하는 것입니다.
- 공백으로 구분된 필드를 처리하는 것입니다.

---

## netstat - 네트워크
> 네트워크 연결, 라우팅 테이블, 인터페이스 통계, 마스커레이드 연결 및 멀티캐스트 구성원 인쇄

```sh
[vagrant@localuser vagrant]$ sudo netstat -nutlp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      902/sshd            
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      1049/master         
tcp6       0      0 :::22                   :::*                    LISTEN      902/sshd            
tcp6       0      0 ::1:25                  :::*                    LISTEN      1049/master         
udp        0      0 0.0.0.0:38246           0.0.0.0:*                           712/dhclient        
udp        0      0 127.0.0.1:323           0.0.0.0:*                           626/chronyd         
udp        0      0 0.0.0.0:68              0.0.0.0:*                           712/dhclient        
udp6       0      0 :::51852                :::*                                712/dhclient        
udp6       0      0 ::1:323                 :::*                                626/chronyd         

[vagrant@localuser vagrant]$ sudo netstat -nutlp | grep 22
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      902/sshd            
tcp6       0      0 :::22                   :::*                    LISTEN      902/sshd            
[vagrant@localuser vagrant]$ 
```

## sort - 정렬

```sh
NAME
       sort - 텍스트 파일 줄 정렬

SYNOPSIS
       sort [OPTION]... [FILE]...
       sort [OPTION]... --files0-from=F

DESCRIPTION
       모든 file(들)의 정렬된 연결을 표준 출력에 씁니다.
```

### Option
| Option | Description | 
| --- | --- | 
| -r, --reverse | 비교 결과를 반전 시킵니다. |
| -n, --numeric-sort | 문자열 수의 값에 따라 비교 |
| -c, --check, --check=diagnose-first | 정렬된 입력을 확인하십시오; 정렬하지 않음 |
| -u, --unique | -c를 사용하여 엄격한 순서를 확인합니다. -c가 없으면 동일한 실행의 첫 번째만 출력 |
| -k, --key=KEYDEF | 키를 통해 정렬; KEYDEF는 위치와 유형을 제공합니다. |
| -t, --field-separator=SEP | 비공백에서 공백 전환 대신 SEP 사용 |

### Example
```sh
[vagrant@localuser ~]$ sort /etc/passwd
adm:x:3:4:adm:/var/adm:/sbin/nologin
bin:x:1:1:bin:/bin:/sbin/nologin
chrony:x:998:996::/var/lib/chrony:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
...
```
- 알파벳순으로 정렬

```sh
sort /etc/passwd | less
adm:x:3:4:adm:/var/adm:/sbin/nologin
bin:x:1:1:bin:/bin:/sbin/nologin
chrony:x:998:996::/var/lib/chrony:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
...
```

정렬 순서를 반대로 하려면 `-r` 옵션을 사용하십시오.
```sh
sort -r /etc/passwd | less
yoonsam:x:1001:1002:Lee Yoon Sam:/home/yoonsam:/bin/bash
vboxadd:x:997:1::/var/run/vboxadd:/bin/false
vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
...
```

**숫자 기준 정렬**
```sh
[vagrant@localuser ~]$ cut -d ':' -f 3 /etc/passwd | sort -n
0
1
2
3
4
...

[vagrant@localuser ~]$ cut -d ':' -f 3 /etc/passwd | sort -nr
65534
1002
1001
1000
...
```
- `-n` 숫자에 따른 정렬 + `-r` 로 결과를 반전

```sh
cut -d ':' -f 3 /etc/passwd | sort -nu
0
1
2
3
4
...
```
- 값이 중복되지 않도록 유니크한 값만 출력

**sort -t -k 사용**
```sh
[vagrant@localuser ~]$ cat /etc/passwd | sort -t ':' -k 3 -n
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
...
```
- `-t ':'` 공백 전환을 `:` 로 변경
- `-k 3` 3번째 컬럼으로 비교해서 정렬

## du - 디스크 사용량
```sh
이름
    du - 파일 공간 사용량 추정

개요
    du [OPTION]... [FILE]...
    du [OPTION]... --files0-from=F

설명
    디렉터리에 대해 재귀적으로 각 FILE의 디스크 사용량을 요약합니다.
    긴 옵션에 대한 필수 인수는 짧은 옵션에도 필수입니다.
```

### Option
| Option | Description | 
| --- | --- | 
| -h, --human-readable | 사람이 읽을 수 있는 형식의 인쇄 크기(예: 1K 234M 2G) |

### Example
**`/var`에서 얼마나 많은 공간이 사용되고 있는지 봅시다.**

```sh
[vagrant@localuser ~]$ sudo du /var
4	/var/nis
4	/var/db/sudo/lectured
8	/var/db/sudo
20	/var/db
4	/var/local
4	/var/gopher
...
```
- 첫 번째 열은 디스크 사용량을 나타내는 숫자이며 기본적으로 이 숫자는 킬로바이트 단위입니다.
- 두 번째 열은 특정 양의 스토리지를 사용하고 있는 관련 디렉토리입니다.

이제 숫자 정렬을 수행하여 가장 많은 공간을 사용하는 디렉터리 및 포워드 `/var`를 찾습니다.
```sh
[vagrant@localuser ~]$ sudo du /var | sort -n
0	/var/lib/nfs/rpc_pipefs
0	/var/lib/nfs/rpc_pipefs/cache
0	/var/lib/nfs/rpc_pipefs/gssd
0	/var/lib/nfs/rpc_pipefs/gssd/clntXX
0	/var/lib/nfs/rpc_pipefs/lockd
...
```

크기와 킬로바이트를 보고 싶지 않은 경우 `-h` 옵션을 사용하면 사람이 읽을 수 있는 형식으로 크기를 인쇄할 수 있습니다.
```sh
[vagrant@localuser ~]$ sudo du -h /var
4.0K	/var/nis
4.0K	/var/db/sudo/lectured
...
1.7M	/var/cache/man
1.7M	/var/cache
109M	/var
...
```


## uniq - 중복 제거
```sh
이름
    uniq - 반복되는 줄 보고 또는 생략

개요
    uniq [OPTION]... [INPUT [OUTPUT]]

설명
    INPUT(또는 표준 입력)에서 인접한 일치 라인을 필터링하여 OUTPUT(또는 표준 출력)에 기록합니다.
    옵션이 없으면 일치하는 줄이 첫 번째 항목에 병합됩니다.
    긴 옵션에 대한 필수 인수는 짧은 옵션에도 필수입니다.
```

### Option
| Option | Description | 
| --- | --- | 
| -c, --count | 발생횟수를 행의 접두사로 표시 |

### Exmaple
```sh
[vagrant@localuser ~]$ netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c
      2 22
      2 25
      1 68
      2 323
      1 25480
      1 42484
```


## wc - 파일 문자 정보
```sh
이름
    wc - 각 파일에 대한 개행 문자, 단어 및 바이트 수를 인쇄합니다.

개요
    wc [OPTION]... [FILE]...
    wc [OPTION]... --files0-from=F

설명
    각 FILE에 대한 개행, 단어 및 바이트 수를 인쇄하고 둘 이상의 FILE이 지정된 경우 전체 라인을 인쇄합니다. FILE이 없거나 FILE이 -이면 표준 입력을 읽습니다. 단어는 공백으로 구분된 길이가 0이 아닌 일련의 문자입니다. 아래 옵션은 인쇄할 개수를 선택하는 데 사용할 수 있으며, 항상 줄수, 단어 수, 문자 수, 바이트 수, 최대 줄 길이의 순서로 표시됩니다.
```

### Option
| Option | Description | 
| --- | --- | 
| -c, --bytes | 바이트 수를 출력 |
| -l, --lines | 개행 횟수를 출력 |
| -w, --words | 단어 수를 출력 |

### Example
```sh
[vagrant@localuser ~]$ wc /etc/passwd
  26   41 1227 /etc/passwd
```
- 첫 번째 열은 파일의 줄 수
- 두 번째 열은 단어 수
- 세 번째 열은 문자 수
- 공백으로 제한되는 0이 아닌 길이의 문자 시퀀스로 단어를 간주합니다.

-w를 사용하여 wc가 단어 수를 표시하도록 할 수 있습니다.
```sh
[vagrant@localuser ~]$ wc -l /etc/passwd
26 /etc/passwd
[vagrant@localuser ~]$ wc -w /etc/passwd
41 /etc/passwd
[vagrant@localuser ~]$ wc -c /etc/passwd
1227 /etc/passwd
```

---

## geoiplookup - IP 주소 또는 호스트 이름을 사용하여 국가 조회
```sh
이름
    geoiplookup - IP 주소 또는 호스트 이름을 사용하여 국가 조회

개요
    geoiplookup [-d 디렉터리] [-f 파일명] [-v] <ip주소|호스트명>

설명
    geoiplookup은 GeoIP 라이브러리와 데이터베이스를 사용하여 IP 주소 또는 호스트 이름의 출처 국가를 찾습니다.
```

### Example

**IP 로 국가 조회**
```sh
[vagrant@localuser vagrant]$ geoiplookup 80.60.233.195
GeoIP Country Edition: NL, Netherlands
```

**IP 로 국가 조회 후 국가 이름만 사용하도록 awk 활용**
```sh
[vagrant@localuser vagrant]$ geoiplookup 80.60.233.195 | awk -F ', ' '{print $2}'
Netherlands
```

---

# sed (Stream Editor) - 입력 스트림에서 기본 텍스트 변환을 수행

```sh
[vagrant@localuser vagrant]$ type -a sed
sed is /usr/bin/sed
```
- `sed` 명령은 셸이 내장된 것이 아니라 독립 실행형 유틸리티 입니다.

```sh
NAME
    sed - 텍스트 필터링 및 변환을 위한 스트림 편집기

SYNOPSIS
    sed [옵션]... {스크립트-온리-아이에프-노-다른-스크립트} [입력-파일]...

설명
     sed는 스트림 편집기입니다.  스트림 편집기는 입력 스트림(파일 또는 파이프라인의 입력)에서 기본적인 텍스트 변환을 수행하는 데 사용됩니다.  동안 스크립트 편집을 허용하는 편집기(예: ed)와 몇 가지 면에서 유사하지만, sed는 입력에 대해 한 번만 통과하여 작동하므로 결과적으로 더 효율적입니다.  그러나 다른 유형의 편집기와 특히 구별되는 점은 파이프라인에서 텍스트를 필터링할 수 있다는 점입니다.
```

### Option
Option | Description
--- | ---

### Example

```sh
[vagrant@localuser vagrant]$ echo 'Dwight is the assistant regional manager.' > manager.txt
[vagrant@localuser vagrant]$ cat manager.txt 
Dwight is the assistant regional manager.
```
- 일반 텍스트 파일 생성

이를 위해 대체 명령을 사용하며 대체 명령은 문자로 표시됩니다.

```sh
[vagrant@localuser vagrant]$ sed 's/assistant/assistant to the/' manager.txt
Dwight is the assistant to the regional manager.

[vagrant@localuser vagrant]$ cat manager.txt 
Dwight is the assistant regional manager.
```
- `s` 뒤에는 슬래시 다음에 대체하려는 텍스트를 입력하고 다시 슬래시를 사용합니다.
- 참고로 슬래시는 구분 기호 역할을 하며 슬래시 사이의 텍스트를 검색 패턴이라고 합니다. 이 검색 패턴은 실제로 정규 표현식이므로 원하는 경우 매우 고급 검색을 수행할 수 있습니다.
- 이 경우에는 sed를 사용하여 일부 텍스트를 찾아서 바꾸는 개념을 보여주기 위해 간단하게 설명하겠습니다.
- 다음으로 이전에 지정한 텍스트를 대체할 텍스트를 입력합니다.
- `assistant`를 `assistant to the`로 변경하고 싶으므로 이렇게 입력합니다.
- 마지막으로 어떤 파일을 입력으로 사용할지 알립니다. (manager.txt)
- 원본 파일은 수정되지 않습니다.

```sh
[vagrant@localuser vagrant]$ echo 'I love my wife.' > love.txt
[vagrant@localuser vagrant]$ cat love.txt
I love my wife.
[vagrant@localuser vagrant]$ sed 's/wife/sed/' love.txt
I love my sed.
[vagrant@localuser vagrant]$ sed 's/MY WIFE/sed/' love.txt
I love my wife.
```
- 소문자/대문자를 구분하며 일치하지 않을 경우 아무런 일도 일어나 않습니다.

**대소문자 구분하지 않게 처리**
```sh
[vagrant@localuser vagrant]$ sed 's/MY WIFE/sed/i' love.txt
I love sed.
```
- 대소문자를 무시하라고 했기 때문에 텍스트가 바뀌어서 다음과 같이 보입니다.

```sh
[vagrant@localuser vagrant]$ echo 'This is line 2.' >> love.txt
[vagrant@localuser vagrant]$ cat love.txt
I love my wife.
This is line 2.
[vagrant@localuser vagrant]$ echo 'I love my wife with all of my heart' >> love.txt
[vagrant@localuser vagrant]$ cat love.txt
I love my wife.
This is line 2.
I love my wife with all of my heart
[vagrant@localuser vagrant]$ sed 's/my wife/sed/' love.txt
I love sed.
This is line 2.
I love sed with all of my heart
```
- 파일에서 한 줄을 읽고 해당 줄에 대해 따옴표로 묶인 설정된 명령을 실행하는 것입니다. 그런다음 다음 줄로 이동하여 파일 끝에 도달할 때까지 동일한 작업을 수행합니다.


```sh
[vagrant@localuser vagrant]$ echo 'I love my wife and my wife loves me. Also, my wife loves the cat.' >> love.txt
[vagrant@localuser vagrant]$ cat love.txt 
I love my wife.
This is line 2.
I love my wife with all of my heart
I love my wife and my wife loves me. Also, my wife loves the cat.
[vagrant@localuser vagrant]$ sed 's/my wife/sed/' love.txt
I love sed.
This is line 2.
I love sed with all of my heart
I love sed and my wife loves me. Also, my wife loves the cat.
```
- 줄단위로 변경을 처리하는데 제일 처음 찾아서 교체 한 후 종료가 됩니다.

이 동작을 재정의하려면 `g 플래그`를 사용해야 합니다.
`g`는 글로벌 교체에서와 같이 글로벌을 염색하는 것으로 생각할 수 있습니다.
```sh
[vagrant@localuser vagrant]$ sed 's/my wife/sed/g' love.txt
I love sed.
This is line 2.
I love sed with all of my heart
I love sed and sed loves me. Also, sed loves the cat.
```

검색 패턴의 두 번째 발생 항목을 바꾸려면 숫자 `2`를 플래그로 사용합니다.
```sh
[vagrant@localuser vagrant]$ sed 's/my wife/sed/2' love.txt
I love my wife.
This is line 2.
I love my wife with all of my heart
I love my wife and sed loves me. Also, my wife loves the cat.
```

이를 수행하는 한 가지 방법은 설정 명령의 출력을 파일로 리디렉션하는 것입니다.
```sh
[vagrant@localuser vagrant]$ sed 's/my wife/sed/g' love.txt > my-new-love.txt
[vagrant@localuser vagrant]$ cat my-new-love.txt 
I love sed.
This is line 2.
I love sed with all of my heart
I love sed and sed loves me. Also, sed loves the cat.
```

**파일을 변경하기 전에 백업 사본 만들기 (-i.bak)**
```sh
[vagrant@localuser vagrant]$ sed -i.bak 's/my wife/sed/' love.txt
[vagrant@localuser vagrant]$ ls
love.txt    love.txt.bak    ...

[vagrant@localuser vagrant]$ cat love.txt
I love sed.
This is line 2.
I love sed with all of my heart
I love sed and my wife loves me. Also, my wife loves the cat.

[vagrant@localuser vagrant]$ cat love.txt.bak
I love my wife.
This is line 2.
I love my wife with all of my heart
I love my wife and my wife loves me. Also, my wife loves the cat.
```
- `-i.bak` 에 공백이 들어가면 에러가 발생합니다.
- 실제 파일이 변경되고 `.bak` 파일로 백업 사본이 생성됩니다.

**변경이 일치하는 줄만 백업을 생성 (w)**
```sh
[vagrant@localuser vagrant]$ sed 's/love/like/gw like.txt' love.txt
I like sed.
This is line 2.
I like sed with all of my heart
I like sed and my wife likes me. Also, my wife likes the cat.

[vagrant@localuser vagrant]$ cat like.txt
I like sed.
I like sed with all of my heart
I like sed and my wife likes me. Also, my wife likes the cat.
```
- `w` 플래그를 사용해서 변경이 일치하는 줄만 `life.txt` 파일에 저장 합니다.

명령 파이프라인은 원하는 방식으로 데이터를 표시하기 위해 필요한 만큼의 명령을 함께 묶을 수 있기 때문에 매우 강력합니다.

**특수문자 처리(`\`)**
```sh
[vagrant@localuser vagrant]$ echo '/home/jason' | sed 's/\/home\/jason/\/export\/users\/jasonc/'
/export/users/jasonc

[vagrant@localuser vagrant]$ echo '/home/jason' | sed 's#/home/jason#/export/users/jasonc#'
/export/users/jasonc

[vagrant@localuser vagrant]$ echo '/home/jason' | sed 's:/home/jason:/export/users/jasonc:'
/export/users/jasonc
```
- 검색 패턴이나 대체 텍스트에 슬래시를 사용해야 하는 경우 다른 **구분 기호**를 선택하세요.

### 언제 사용하면 좋을지
예를 들어 새 웹사이트를 지속적으로 배포하면서 웹사이트 이름만 제외하고 동일한 구성을 사용하는 경우 모든 표준 구성과 웹사이트 이름 자리 표시자를 포함하는 템플릿 파일을 만드는 것이 좋습니다.

그런 다음 배포할 준비가 되면 `sed`를 사용하여 모든 자리 표시자를 실제 웹사이트 이름으로 간단히 바꿀 수 있습니다.

- 대체 기능을 사용할 수 있는 또 다른 예로는 한 서버에서 다른 서버로 마이그레이션하거나 한 서버의 복원을 사용하여 다른 새 서버를 만들 때입니다.
    - 이 예에서는 `/etc/hosts` 및 `/etc/hostname`과 같은 `etc` 디렉토리 파일에 있는 모든 파일에 대해 이전 호스트명을 찾아서 새 호스트명으로 바꿔야 하며, 시스템 구성에 따라 다른 호스트명이 있을 수도 있습니다.

- 특정 서비스에 대한 구성을 한 호스트에서 다른 호스트로 복사할 때, 특히 클러스터에서 작업하는 경우 이 작업을 수행하게 될 수 있습니다.
    - 한 호스트에서 클러스터에 추가할 새 호스트로 구성을 복사하기만 하면 됩니다.
    - 일반적으로 구성 파일에서 호스트 이름을 변경해야 하며, 해당 호스트 이름이 해당 구성에 여러 번 나타나는 경우 이 작업을 위해 `sed`를 사용하면 특히 유용할 수 있습니다.

`sed` 대체 명령을 사용하여 `sed`가 포함된 일부 줄을 제거하거나 삭제하고 싶다고 가정해 보겠습니다.

'모든 사람에게 거짓말을 하고 있다'는 문구를 삭제하려면 다른 문구가 아닌 해당 문구와 일치하는 검색 패턴을 찾아야 합니다.
따라서 이 단어는 삭제하려는 줄에만 나타나므로 이 검색 패턴을 사용할 수 있습니다.

검색 패턴은 `this`이고 명령은 `d`입니다.
```sh
[vagrant@localuser vagrant]$ cat love.txt
I love sed.
This is line 2.
I love sed with all of my heart
I love sed and my wife loves me. Also, my wife loves the cat.

[vagrant@localuser vagrant]$ sed '/This/d' love.txt
I love sed.
I love sed with all of my heart
I love sed and my wife loves me. Also, my wife loves the cat.
```
- 여기서 명확히 하기 위해 구문은 구분 기호이며 기본적으로 슬래시를 구분 기호로 사용하고 그 뒤에 검색 패턴과 닫는 구분 기호를 사용합니다.
- `d`는 일치하는 줄을 삭제하라고 지시합니다.
- `This` 라는 텍스트가 포함되어 있는 라인을 삭제 합니다.

```sh
[vagrant@localuser vagrant]$ sed '/love/d' love.txt
This is line 2.
```
- `love` 가 들어가는 텍스트의 라인을 삭제 합니다.


### 줄이 많은 구성 파일로 작업할 때 주석을 제거

**comment 삭제**

```sh
[vagrant@localuser vagrant]$ sed '/^#/d' config
User apache

Group apache
```
- 검색 패턴은 실제로 정규식의 정규 표현식이라는 점을 기억하세요.
- `#` 으로 시작하는(`^`, carrot) 줄을 삭제(`d`)

**빈줄 제거**
```sh
[vagrant@localuser vagrant]$ sed '/^$/d' config
User apache
# Group to run service as.
Group apache
```
- `^(당근 기호)`는 줄의 시작 부분과 일치합니다.
- `$(달러 기호)`는 줄의 끝과 일치합니다.
- 줄의 시작 바로 뒤에 다른 방식으로 말한 줄의 끝이 있는 경우.
- `^$`는 빈 줄과 일치합니다.

여러 명령어 또는 표현식을 사용하려면 이들을 `결합`해야 합니다.

`;(세미콜론)`으로 결합 할 수 있습니다.
```sh
[vagrant@localuser vagrant]$ sed '/^#/d ; /^$/d' config
User apache
Group apache
```

추가로 **apach** 를 **httpd**로 변경해서 결합 보겠습니다.
```sh
[vagrant@localuser vagrant]$ sed '/^#/d ; /^$/d ; s/apache/httpd/' config
User httpd
Group httpd
```
- `;` 으로 구분해서 패턴을 추가하면 조합을 할수 있습니다.

위 명령을 여러 번 실행하는 또 다른 방법

주로 대본이나 다른 사람의 작품에서 우연히 보게 될 경우를 대비해 보여드리고자 합니다.
따라서 이 작업을 수행하는 다른 방법은 실행할 각 명령에 대해 여러 옵션을 사용하는 것입니다.

```sh
[vagrant@localuser vagrant]$ sed -e '/^#/d' -e '/^$/d' -e 's/apache/httpd/' config
User httpd
Group httpd
```
- `-e` 옵션을 사용해서 패턴을 하나씩 입력하는 방식

```sh
[vagrant@localuser vagrant]$ echo '/^$/d' > script.sed
[vagrant@localuser vagrant]$ echo '/^#/d' > script.sed
[vagrant@localuser vagrant]$ echo '/^$/d' >> script.sed
[vagrant@localuser vagrant]$ echo 's/apache/httpd/' >> script.sed
[vagrant@localuser vagrant]$ cat script.sed
/^#/d
/^$/d
s/apache/httpd/
[vagrant@localuser vagrant]$ sed -f script.sed config
User httpd
Group httpd
```
- 패턴을 라인단위로 입력한 파일을 생성 후 `sed -f` 옵션을 사용해서 파일로 패턴 검색하는 방식

주소와 주소 결정자를 사용하여 해당 명령이 어떤 줄에서 실행될지 결정하는 방법을 살펴보겠습니다.

주소가 지정되지 않으면 모든 줄에서 명령이 수행됩니다.

주소는 `sed` 명령 앞에 지정됩니다.

가장 간단한 주소는 회선 번호입니다.

다음은 파일의 두 번째 줄에 대해서만 실행되는 예제입니다.
```sh
[vagrant@localuser vagrant]$ cat config
# User to run service as.
User apache

# Group to run service as.
Group apache

[vagrant@localuser vagrant]$ sed '2 s/apache/httpd/' config
# User to run service as.
User httpd

# Group to run service as.
Group apache
```
- apache의 검색 패턴은 두 번째 줄에서만 httpd 로 대체되었습니다.
- `2s/apache/httpd/` 처럼 붙여서 써도 같은 결과가 나옵니다. 

`Group`이라는 단어가 포함된 줄에서만 `apache` 를 `httpd` 로 바꾸고 싶다고 가정해 보겠습니다.
```sh
[vagrant@localuser vagrant]$ sed '/Group/ s/apache/httpd/' config
# User to run service as.
User apache

# Group to run service as.
Group httpd
```

쉼표로 구분하여 주소 사양을 지정하여 범위를 지정할 수도 있습니다.
```sh
[vagrant@localuser vagrant]$ sed '1,3 s/run/execute/' config
# User to execute service as.
User apache

# Group to run service as.
Group apache
[vagrant@localuser vagrant]$ sed '1,4 s/run/execute/' config
# User to execute service as.
User apache

# Group to execute service as.
Group apache
[vagrant@localuser vagrant]$ 
[vagrant@localuser vagrant]$ 
[vagrant@localuser vagrant]$ 
[vagrant@localuser vagrant]$ sed '/# User/, /^$/ s/run/execute/' config
# User to execute service as.
User apache

# Group to run service as.
Group apache
```
- `# User`로 시작하는 줄과 다음 빈 줄 사이에 있는 모든 실행 인스턴스가 텍스트 실행으로 교환된 것을 볼 수 있습니다.


# tee
이름
    tee - 표준 입력에서 읽고 표준 출력 및 파일에 쓰기

SYNOPSIS
    tee [OPTION]... [FILE]...

설명
    표준 입력을 각 파일과 표준 출력으로 복사합니다.

### Option
Option | Description
--- | ---
-a, --append | 주어진 파일에 추가하고 덮어쓰지 마십시오.

### Example
```sh
[vagrant@admin01 ~]$ echo '10.9.8.11 server01' | sudo tee -a /etc/hosts
10.9.8.11 server01
[vagrant@admin01 ~]$ echo '10.9.8.12 server02' | sudo tee -a /etc/hosts
10.9.8.12 server02
[vagrant@admin01 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
127.0.1.1 admin01 admin01
10.9.8.11 server01
10.9.8.12 server02
```
- `/etc/hosts` 파일에 `ip` 주소와 이름을 추가 합니다.


## Positional Parameters

파라미터 | 설명
--- | ---
$0 | 스크립트 이름을 저장
$1 | 첫번째 인자를 저장
$2 | 두번째 인자를 저장
$* | 따옴표로 묶어 사용: "$1 $2..."
$@ | 따옴표로 묶어 사용: "$1" "$2" ..
$# | Positional Parameter 갯수