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
> 새로운 사용자를 생성하거나 새로운 사용자의 기본 정보를 수정합니다.

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


## basename
> 파일 이름에서 디렉토리 및 접미사 제거

```sh
basename /vagrant/luser-demo06.sh 
>> luser-demo06.sh
```
- 기본 이름을 제공할 수 있도록 전달된 문자열의 디렉토리 부분을 제거합니다.

## dirname
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

## for 커맨드에서 사용하기
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