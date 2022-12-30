# Local Users

Shell Script 표현식 | 부르는 이름
--- | ---
\# | Sharp
! | Bang
#! | shebang (shebang이라고 불리는 이유는 파운드 기호가 때때로 샤프라고 불리기 때문입니다.)


## 내장함수
| 명령어 | 설명 |
| --- | --- |
| type -a command | 시스템에서 Echo의 모든 인스턴스를 보려면 모두 A를 입력한 다음 echo를 입력합니다. |
| echo "some text" | 출력 |
| help echo \|less  | echo 에 대한 설명을 줄여서 보여줌 |

## Variables
```sh
WORD='script'

echo "WORD" # -> script
echo 'WORD' # -> $WORD
```
- 구체적이고 아무 것도 변경되지 않도록 하려면 작은따옴표를 사용하십시오.

<br/>
<br/>

# 13. Special Variables, Pseudocode, Command Substitution, if Statement, Conditionals.

**배울내용**
- 쉘이 생성하는 몇 가지 특수 변수
- 변수에 있는 명령의 출력
- if 문


### Root User or not

**General**
```
./luser_demo02.sh
```

**Root**
```
sudo ./luser_demo02.sh
```

## Linux Shell Scripting: A Project-Based Approach to Learning
- `if` 문과 함께 사용하는 이 이중 괄호 구문은 `bash` 전용

<br/>
<br/>

# 14. Exit Statuses, Return Codes, String Test Conditionals, More Special Variables.

**배울 내용**
- if 표현식에서 참이 아니면 무언가를 하라는 논리를 사용
- 종료 명령의 상태를 확인하여 주어진 명령이 실패했는지 또는 성공했는지 확인하는 방법
- 스크립트의 종료 상태를 제어하는 ​​방법

1. 가상머신을 시작하고 연결
```shell
cd shellclass
cd localusers
vagrnat up
```
- 폴더 이동 후 가상머신 시작 및 연결

```shell
vagrant ssh
```
- ssh 접속

```shell
cd /vagrant
```
- 이제 가상 머신 내부에 있으므로 Slash Vagrant의 공유 디렉토리에 시드할 것입니다.

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
