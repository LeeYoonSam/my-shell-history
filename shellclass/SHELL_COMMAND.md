# Shell Commands

### exit
> 스크립트 실행을 중지하기 위해 exit 명령을 사용합니다.

- exit 명령어 뒤에 종료 상태를 제공할수 있습니다.
- 일반적으로 스크립트나 프로그램이 성공적으로 실행되면 종료 상태 0을 반환합니다.
- 어떤 이유로든 성공적으로 실행되지 않으면 0이 아닌 종료 상태를 반환합니다.
- 원하는 경우 다양한 종료 상태를 사용할 수 있습니다.

### useradd
> 새로운 사용자를 생성하거나 새로운 사용자의 기본 정보를 수정합니다.

### test
> 조건식을 평가 합니다.<br/>
EXPR 평가에 따라 0(참) 또는 1(거짓) 상태로 종료합니다.<br/>
식은 단항 또는 이항일 수 있습니다.<br/>
단항식은 종종 파일의 상태를 검사하는 데 사용됩니다.<br/>
문자열 연산자와 숫자 비교 연산자도 있습니다.

**File operators**
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

**String operators**    
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

**Other operators**
```
-o OPTION      True if the shell option OPTION is enabled.
-v VAR	 True if the shell variable VAR is set
! EXPR         True if expr is false.
EXPR1 -a EXPR2 True if both expr1 AND expr2 are true.
EXPR1 -o EXPR2 True if either expr1 OR expr2 is true.

arg1 OP arg2   Arithmetic tests.  OP is one of -eq, -ne,
                -lt, -le, -gt, or -ge.
```

### $()
> 명령의 출력을 캡처하는 데 사용됩니다.

```shell
USER_NAME=$(id -un)
```
- 명령의 출력을 보내고 `USER_NAME` 변수에 저장

### ${?}
> Barish는 설정하는 몇 가지 특수 변수가 있으며 이러한 특수 변수 중 하나는 `${?}` 입니다.

- 가장 최근에 실행된 명령의 종료 상태를 보유합니다.

### `=` or `==`

`if [[ left = right ]]`
- left 와 right 를 비교하는 것
- 정확히 일치하는 항목을 찾을때 하나의 등호만 사용합니다.

`if [[ left == right ]]`
- right 연산자를 패턴으로 사용하여 패턴 매칭을 수행합니다.

