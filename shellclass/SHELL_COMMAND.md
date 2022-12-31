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