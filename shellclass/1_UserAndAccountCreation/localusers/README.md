# Local Users

## 시작시 공통으로 해야하는 작업
- 가상머신을 시작하고 연결
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


## Shell Script 표현식
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

<br/>
<br/>

# 15. Reading Standard Input, Creating Accounts, Username Conventions, More Quoting.

**배울 내용**
- 스크립트를 실행하는 사람으로부터 입력을 받는 방법
- Linux 시스템에서 계정을 만드는 방법

## 참고
- [Script](./luser-demo04.sh)

# Section 4: Password Generation and ShellScript Arguments

## 18. Random Data, Cryptographic Hash Functions, Text and String Manipulation.
> 랜덤 데이터, 암호화 해시 함수, 텍스트 및 문자열 조작.

**배울 내용**
- 임의의 데이터를 생성하는 몇 가지 다른 방법
- 임의 암호 생성 프로세스를 자동화하는 방법
    - 사용자의 입력을 덜 요구하여 스크립트를 개선

### 참고
- [Script](./luser-demo05.sh)

## 19. Positional Parameters, Arguments, for Loops, Special Parameters

**배울 내용**
- 위치 매개변수와 for 루프

### Parameter vs Argument
명령줄에 인수(Argument)가 적용되면 매개변수(paramenter)에 저장된 값이 됩니다.

**Parameter**
> 매개변수는 쉘 스크립트 내에서 사용되는 변수입니다.

**Argument**
> 인수는 쉘 스크립트로 전달되는 데이터입니다.

### 앞으로 입력할 수 있도록 스크립트의 전체 경로를 제공하여 스크립트를 호출하는 방법
```sh
/vagrant/luser-demo06.sh 
>> You executed this command: /vagrant/luser-demo06.sh
```
- 스크립트가 이와 같이 명시적으로 호출되면 `$0`에 저장됩니다.

### 경로를 제어하려면 스크립트에서 경로를 조작하여 제어할 수 있습니다.
- 어떤 명령이 실행될지 알려주기 위해 `which`라는 명령을 사용합시다.
```sh
which head
>> /usr/bin/head
```
- `PATH` 변수의 첫 번째 디렉토리는 실제로 사용자 로컬 bin입니다.

이제 head라는 이름의 쉘 스크립트를 만들어 거기에 배치해 봅시다. 
이를 위해서는 루트 권한이 필요합니다.

```sh
sudo vim /usr/local/bin/head

...

echo 'Hello from my head.'
```
- /usr/local/bin 에 head 파일 추가

```sh
chmod 755 /usr/local/bin/head
which head
>> /usr/local/bin/head
```

```sh
which -a head
/usr/local/bin/head
/usr/bin/head
```
- 둘 다 head라는 이름이 붙지만 처음 발견된 것이 실행됩니다.

```sh
head
>> Hello from my head.
```

기본값을 재정의 하려면 `usr/bin/head` 와 함께 수행할수 있도록 전체 경로를 제공
```sh
/usr/bin/head -n1 /etc/passwd
>> root:x:0:0:root:/root:/bin/bash
```

### Bash 에서 Path
`Bash`는 해시 테이블을 사용하여 실행 파일의 전체 경로 이름을 기억합니다.<br/>
실행 파일의 위치를 ​​한 번 조회한 다음 기억합니다.<br/>
여기에서 수행할 type head 명령을 보면 `usr/local/bin/head`가 해시된 것으로 표시됩니다.<br/>
이는 bash가 해당 명령을 먼저 검색하지 않고 경로에서 해당 명령을 실행한다는 의미입니다.<br/>

```sh
sudo cp luser-demo06.sh /usr/local/bin/
which luser-demo06.sh
>> /usr/local/bin/luser-demo06.sh

luser-demo06.sh 
You executed this command: /usr/local/bin/luser-demo06.sh
```
이제 스크립트가 `PATH` 에 있으므로 스크립트 경로를 제공하지 않고도 실행할 수 있습니다.<br/>
입력만 했는데도 `usr/local/bin/luser-demo-06.sh` 명령의 전체 경로입니다.<br/>
명령줄에서 Bash는 우리 경로에서 그것을 찾아 해당 경로에서 실행했습니다.<br/>
이것이 `PATH`와 파일이 `$0`에 저장되는 이유입니다.

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

**for 문에 ${@} 사용시 인수 각각 적용**
```sh
./luser-demo06.sh
>> You used . as the path to the luser-demo06.sh script.
>> You supplied 4 argument(s) on the command line.
>> jason: 3e98e629bf790b2e627bb1346005dcef34a594fa9dfb3834
>> steve: 109d5d4ec6e22d1929075ae1f6a0d863d0d7aa3697f9d7e8
>> jan: 10fe2cbfb6222ca5eb6be9d97c63a98fb2e98da5a96dfc78
>> fred: 628af4976bbd8e6eb3c0c99c5a0f70628417abe662e197ea
```

**for 문에 ${*} 사용시 하나의 인수로 적용**
```sh
./luser-demo06.sh  jason steve jan fred
>> You executed this command: ./luser-demo06.sh
>> You used . as the path to the luser-demo06.sh script.
>> You supplied 4 argument(s) on the command line.
>> jason steve jan fred: cfe178ea51f0598b6b612e7fe3c549e248934794513b6c70
```

### 참고
- [Script](./luser-demo06.sh)


## 20. The while Loop, Infinite Loops, Shifting, Sleeping

**배울 내용**
- 위치 매개변수를 계속 탐색하고 While loop 생성하는 방법

### shift
- `shift` 명령이 실제로 수행하는 작업은 목록에서 위치 매개변수를 `$1`로 제거하는 것입니다.
- `$2`에 저장된 값이 `$1` `$3`으로 이동합니다.
- `${}` 의 특수 매개 변수가 1씩 줄어듭니다.
- `while` 루프가 처음 실행되고 `shift`가 실행되면 매개변수의 수가 줄어듭니다.

### 참고
- [Script](./luser-demo07.sh)

# Section 5: Linux Programming Conventions

## 23. Advanced Standard Input, Standard Output, and Standard Error - Part I

**배울 내용**
- 다양한 유형의 입력 및 출력과 리디렉션 방법
- 유형의 입력 및 출력을 제어

### 3가지 `IO` 타입
- Standard Input
    - 키보드로 무언가를 입력하는 사용자로부터 입력
    - `read` 명령은 표준 입력을 받아들이고 `read` 명령을 사용하여 정보를 수집합니다.
    - 파이프를 사용하여 하나의 명령으로 생성된 출력을 표준 입력으로 사용
- Standard Output
    - 명령의 표준 출력을 파일로 리디렉션하여 시작
    - 리디렉션 작업을 할 때 권한이 없으므로 권한 거부 오류가 발생하면 그대로 받아 들입니다.
    - 명령의 출력을 다른 명령의 입력으로 가져오려는 경우 파이프를 사용합니다.
    - 그러나 파일 내용을 명령으로 리디렉션하려는 경우 이 리디렉션을 사용할 수 있습니다.
- Standard Error

파일을 재정의하지 않고 파일을 추가하거나 덧붙이려면 어떻게 해야 합니까?
- `>>` 기호를 사용합니다.

```sh
echo "another-line" >> password

cat password
>> new
>> another-line
```

파이프와 출력 리디렉션을 사용
```sh
date | sha256sum | head -c10 >> password

cat password 
>> new
>> another-line
>> 5756525402
```


## Advanced Standard Input, Standard Output, and Standard Error - Part II

표준 오류 리디렉션을 다루기 전에 `file descriptors`에 대해 이야기해야 합니다.

`file descriptors`는 단순히 열려 있는 파일을 나타내는 숫자입니다.

모든 새로운 프로세스는 세 개의 열린 파일 `file descriptors`로 시작합니다.

- FD 0 - STDIN
- FD 1 - STDOUT
- FD 2 - STDERR

기본적으로 표준 입력은 내 키보드에서 나오지만 내 키보드는 파일이 아닙니다.
그리고 기본적으로 `STDOUT`과 `STDERR`가 내 화면에 표시됩니다.

### 리디렉션
**COMMAND > FILE**
- 표준 출력을 파일로 리디렉션하고 파일을 생성
- 또는 해당 파일이 존재하는 경우 덮어쓰는 파일을 자릅니다.

**COMMAND >> FILE**
- 파일을 덮어쓰지 않고 파일에 추가하려면 `>>` 사용
- 출력 리디렉션에 대해 파일 설명자가 지정되지 않은 경우 파일 설명자 1이 가정됩니다.
- 표준 오류를 리디렉션하기 위해 모든 파일 설명자를 2로 지정해야 했습니다.

**COMMAND &> FILE**
- `&`를 사용하여 표준 입력과 표준 오류를 모두 파일로 리디렉션할 수 있음을 배웁니다.

**COMMAND |& COMMAND**
- 파이프를 통해 표준 입력 및 표준 오류를 리디렉션하려면 `|&` 구문을 사용하십시오.

**COMMAND < FILE**
- `<`를 사용하여 파일의 표준 입력을 명령으로 리디렉션하는 것으로 이동했습니다.

**COMMAND > /dev/null**
- 마지막으로 출력을 `dev/null`로 리디렉션하여 null 장치를 사용하는 방법을 배웠습니다.


예를 들어 `STDIN`을 명령 파일로 리디렉션할 때 `file descriptors` 0이 가정됩니다.

명시적으로 지정하려면 리디렉션 연산자 바로 앞에 `file descriptors` 번호를 지정하십시오.

`file descriptors`를 제공할 때 공백을 사용하지 마십시오.


### 에러 테스트
```sh
head -n1 /etc/passwd /etc/hosts /fakefile

==> /etc/passwd <==
root:x:0:0:root:/root:/bin/bash

==> /etc/hosts <==
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4

head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
```

**file descriptors 2 사용**
```sh
head -n1 /etc/passwd /etc/hosts /fakefile 2> head.err
==> /etc/passwd <==
root:x:0:0:root:/root:/bin/bash

==> /etc/hosts <==
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4

cat head.err
>> head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
```
- 이제 화면에 표시되는 것은 표준 출력이고 표준 오류는 파일로 이동합니다.

**STDIN, STDOUT 두 가지 모두 파일로 처리**
```sh
head -n1 /etc/passwd /etc/hosts /fakefile > head.out 2> head.err

cat head.out
==> /etc/passwd <==
root:x:0:0:root:/root:/bin/bash

==> /etc/hosts <==
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4

cat head.err
head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
```

**파일 덮어쓰기**
```sh
head -n1 /etc/passwd /etc/hosts /fakefile > head.out 2>> head.err

cat head.out
==> /etc/passwd <==
root:x:0:0:root:/root:/bin/bash

==> /etc/hosts <==
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4

cat head.err
head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
```

**2가지 모두 파일로 출력**
```sh
head -n1 /etc/passwd /etc/hosts /fakefile > head.both 2>&1

cat head.both 
==> /etc/passwd <==
root:x:0:0:root:/root:/bin/bash

==> /etc/hosts <==
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
```
- 일반적으로 파일 리디렉션은 리디렉션 연산자를 따릅니다. 파일 이름 대신 파일 설명자를 사용하려면 `&` 기호를 사용하십시오.
- 표준 오류를 파일로 리디렉션하는 대신 표준 입력으로 리디렉션됩니다.
- `&`를 생략하면 `1`이라는 이름의 파일로 취급됩니다.
- `1`은 `head`의 표준 출력을 `head.both`라는 파일로 보내고 표준 오류를 표준 출력 다음에 추가합니다.
- 여기에서 간격도 중요하다는 점을 지적하고 싶습니다. 리디렉션 연산자와 `&` 뒤에 공백을 사용하지 마십시오.

```sh
head -n1 /etc/passwd /etc/hosts /fakefile | cat -n

head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
    1	==> /etc/passwd <==
    2	root:x:0:0:root:/root:/bin/bash
    3	
    4	==> /etc/hosts <==
    5	127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
```
- 파이프(`|`)를 통과하지 않았기 때문에 첫 번째 표준 오류가 화면에 표시됩니다.
- `head` 명령의 표준 출력은 파이프를 통해 `cat` 명령에 대한 입력으로 전달되었습니다.

표준 출력만 받는 파이프에 대해 아는 것이 중요합니다. 이것은 파이프로 작업할 때 원하는 작업 방식과 정확히 일치할 수 있습니다. 아니면 그렇지 않을 수도 있습니다.

**파이프를 통해 명령의 모든 출력을 강제**하려면 표준 입력에 표준 오류를 추가해야 합니다.
따라서 이를 수행할 수 있는 한 가지 방법은 파일 설명자를 2로 지정하는 것입니다. 이는 표준 오류를 위한 것입니다.

```sh
1	==> /etc/passwd <==
2	root:x:0:0:root:/root:/bin/bash
3	
4	==> /etc/hosts <==
5	127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
6	head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
```
- 이제 표준 오류가 표준 출력으로 이동하고 모든 표준 출력이 파이프를 통과하므로 cat은 모든 행을 계산해야 합니다.

```sh
head -n1 /etc/passwd /etc/hosts /fakefile |& cat -n
     1	==> /etc/passwd <==
     2	root:x:0:0:root:/root:/bin/bash
     3	
     4	==> /etc/hosts <==
     5	127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
     6	head: cannot open `/fakefile' for reading: 그런 파일이나 디렉터리가 없습니다
```
- `|&` 를 사용해도 같은 결과를 나타냅니다.

### 참고
- [Script](./luser-demo08.sh)

# Section 6: Parsing Command Line Options

## 27. Case Statements

**배울 내용**
- case 문을 사용하는 방법

```sh
type -a case
case is a shell keyword
```

case 문은 주어진 변수의 값을 기반으로 결정을 내리는 완벽한 방법입니다.
찾고 있는 특정 값 집합이 있는 경우 특히 그렇습니다.<br/>
쉘이 내장되어 있기 때문에 사용 방법에 대한 정보를 내장된 `help`로 얻을 수 있습니다.

```sh
help case
```
패턴 일치를 기반으로 명령을 실행합니다.<br/>
WORD 일치 PATTERN을 기반으로 COMMANDS를 선택적으로 실행합니다. `|` 는 여러 패턴을 구분하는 데 사용됩니다.

### 참고
- [Script](./luser-demo09.sh)

## 28. Functions

**배울 내용**
- 스크립트에서 함수를 사용하는 방법

함수는 단순히 스크립트에서 단일 이름을 사용하여 호출하는 명령 그룹입니다.

함수는 기본 스크립트 내부의 작은 스크립트라고 생각할 수 있습니다.

Linux 시스템의 다른 스크립트나 명령과 마찬가지로 함수를 호출하거나 실행할 수 있습니다.

함수를 사용하려는 몇 가지 이유가 있습니다.

**첫 번째 이유**는 스크립트의 여러 위치에 중복 코드가 있는 것을 원하지 않기 때문입니다.

함수를 사용하면 코드를 `Dry`한 상태로 유지할 수 있습니다.

`Dry`는 Don't Repeat Yourself를 나타내는 컴퓨터 프로그래밍 및 응용 프로그램 개발 원칙입니다.

함수를 사용하면 특정 작업을 수행해야 할 때마다 여러 줄의 코드를 반복하는 대신 코드 블록을 한 번 작성하고 여러 번 사용할 수 있습니다.

해당 코드가 포함된 함수를 호출하기만 하면 됩니다.

이것은 스크립트의 길이를 줄이는 데 도움이 되며 주어진 작업을 변경, 테스트, 문제 해결 및 문서화할 수 있는 단일 위치를 제공합니다.


### local(로컬))
> 로컬이 하는 일은 함수의 범위 내에서 변수를 로컬로 만드는 것입니다.<br/>
즉, 해당 변수의 값은 해당 함수 내에서만 액세스할 수 있습니다.

로컬 명령은 함수 내에서만 사용할 수 있습니다.

### 참고
- [Script](./luser-demo10.sh)

## 29. Parsing Command Line Options with `getopts`, Part 1

**배울 내용**
- `getopts`에 내장된 셸을 사용하여 명령줄 옵션을 처리하는 방법

```sh
type -a getopts
getopts is a shell builtin
getopts is /usr/bin/getopts
```

- `getopt` ​는 `getopts`와 매우 유사하지만 고유한 특성 집합에 제한이 있습니다.


```sh
man getopts

`getopts` optstring name [args]
```
- getopts는 쉘 프로시저에서 위치 매개변수를 구문 분석하는 데 사용됩니다. 
- optstring은 인식할 옵션 문자를 포함합니다. 
- 문자 다음에 콜론이 오는 경우 옵션에는 공백으로 구분되는 인수가 있어야 합니다.

### 참고
- [Script](./luser-demo11.sh)


## 30. Parsing Command Line Options with getopts, Part 2

```sh
NUM=$(( 1 + 2 ))
echo $NUM
> 3

NUM=$(( 10 - 1 ))
echo $NUM
> 9

NUM=$(( 2 * 4 ))
echo $NUM
> 8

NUM=$(( 6 / 4 ))
echo $NUM
> 1
```
- Bash는 이중 괄호 안의 산술 표현식을 평가하고 다음을 반환하거나 그 자리에 결과로 대체합니다.
- Bash는 반올림을 수행하지 않습니다. 실제로 Bash는 부동 소수점 산술을 지원하지 않습니다.

소수가 포함된 숫자로 작업해야 하는 경우 Basic Calculator를 나타내는 BC와 같은 프로그램의 외부 함수를 사용해야 합니다.

```sh
type -a bc
bc is /usr/bin/bc
```

### yum 을 통해서 bc 를 설치
```sh
sudo yum install -y bc
```
- 설치되어 있을수도 있고 설치되어 있지 않을수도 있습니다.

**사용법**
```sh
bc -h
usage: bc [options] [file ...]
  -h  --help         print this usage and exit
  -i  --interactive  force interactive mode
  -l  --mathlib      use the predefined math routines
  -q  --quiet        don't print initial banner
  -s  --standard     non-standard bc constructs are errors
  -w  --warn         warn about non-standard bc constructs
  -v  --version      print version information and exit
```

BC로 부동 소수점 연산을 수행하려면 `mathlib`, `-l` 옵션을 켜야 합니다.

```sh
echo '6 / 4' | bc -l
1.50000000000000000000
```

### `math`에 대한 논의를 마무리하기 전에 `math` 연산을 수행하는 다른 두 가지 방법

**let**

첫 번째 방법은 내장된 `let` bash를 사용하는 것입니다.

```sh
type -a let
let is a shell builtin

help let | less
```
- [let](/QuickReferences/SHELL_COMMAND.md#let)


**expr**

`EXPR` 명령은 주어진 표현식을 처리한 다음 그 결과를 표준 출력으로 보냅니다.

- [EXPR](/QuickReferences/SHELL_COMMAND.md#expr)


## 31. Deleting and Disabling Linux Accounts, Part 1 of 4 (Finding Files)

**배울 내용**
- Linux 시스템에서 사용자를 비활성화, 삭제 및 보관하는 방법

```sh
type -a userdel
> -bash: type: userdel: not found

which userdel
> /usr/bin/which: no userdel in (/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/sbin:/home/vagrant/bin)
 
locate userdel
>
/usr/sbin/luserdel
/usr/sbin/userdel
/usr/share/bash-completion/completions/userdel
/usr/share/man/de/man8/userdel.8.gz
/usr/share/man/fr/man8/userdel.8.gz
/usr/share/man/it/man8/userdel.8.gz
/usr/share/man/ja/man8/userdel.8.gz
/usr/share/man/man1/luserdel.1.gz
/usr/share/man/man8/userdel.8.gz
/usr/share/man/pl/man8/userdel.8.gz
/usr/share/man/ru/man8/userdel.8.gz
/usr/share/man/sv/man8/userdel.8.gz
/usr/share/man/tr/man8/userdel.8.gz
/usr/share/man/zh_CN/man8/userdel.8.gz
/usr/share/man/zh_TW/man8/userdel.8.gz
```
- 실제 userdel 이 위치한곳

`locate`가 실시간 데이터를 사용하지 않는다는 것을 증명하기 위해 `userdel` 이라는 파일을 만든다음 `locate` 로 찾습니다.

그래서 홈 디렉토리에서 `touch userdel` 을 합니다.

### touch
> 존재하지 않거나 파일이 존재하는 경우 파일을 터치하고 타임 스탬프를 업데이트합니다.

```sh
touch userdel

ls -l userdel
> -rw-r--r-- 1 vagrant vagrant 0  1월 28 06:30 userdel
```

`touch` 명령을 사용하여 홈 디렉토리를 업데이트하고 DB 업데이트를 실행하는 방법은 전체 파일 시스템을 검색하는 것이며 `vagrant`와 같은 일반 사용자로서 모든 단일 파일에 대한 권한이 없기 때문에 루트 권한이 필요합니다.

```sh
touch userdel
sudo updatedb
locate userdel
>
/home/vagrant/userdel
/usr/sbin/luserdel
/usr/sbin/userdel
/usr/share/bash-completion/completions/userdel
/usr/share/man/de/man8/userdel.8.gz
/usr/share/man/fr/man8/userdel.8.gz
/usr/share/man/it/man8/userdel.8.gz
/usr/share/man/ja/man8/userdel.8.gz
/usr/share/man/man1/luserdel.1.gz
/usr/share/man/man8/userdel.8.gz
/usr/share/man/pl/man8/userdel.8.gz
/usr/share/man/ru/man8/userdel.8.gz
/usr/share/man/sv/man8/userdel.8.gz
/usr/share/man/tr/man8/userdel.8.gz
/usr/share/man/zh_CN/man8/userdel.8.gz
/usr/share/man/zh_TW/man8/userdel.8.gz
```
- 이 작업이 완료되면 userdel을 찾을 수 있으며 출력 맨 위에 표시됩니다.

한 걸음 뒤로 물러서서 먼저 `locate` 명령을 사용하고 실제로 바이너리 또는 실행 파일을 찾고 있기 때문에 `bin` 디렉토리에 있는 항목만 포함하도록 검색을 제한하겠습니다.

이제 `locate` 명령의 표준 출력을 가져와서 `grep` 명령에 대한 표준 입력으로 보냅니다.

`grep` 명령은 패턴과 일치하는 항목을 표시하고 나머지는 모두 버립니다.

```sh
locate userdel | grep bin
/usr/sbin/luserdel
/usr/sbin/userdel
```

때로는 찾고 있는 파일이 권한이 있는 위치에 있지 않은 경우가 있습니다. `locate` 명령은 해당 권한을 존중합니다.

```sh
locate .bashrc
> /etc/skel/.bashrc
> /home/vagrant/.bashrc

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
- 같은 locate .bashrc 명령을 sudo 를 사용한것과 안한것의 차이
- vagrant 사용자로서 우리는 예를 들어 루트의 홈 디렉토리 내부를 볼 수 있는 권한이 없습니다.

여기서 요점은 파일을 일반 일반 사용자로 볼 수 있는 권한이 없기 때문에 파일을 찾기 위해 루트 권한을 사용해야 하는 경우가 있다는 것입니다.
- [sudo !!](/QuickReferences/SHELL_COMMAND.md#L517)

**시스템에서 userdel 이 존재하는지 찾는 과정**
```sh
ls -ld /*bin
> lrwxrwxrwx. 1 root root 7  2월 19  2018 /bin -> usr/bin
> lrwxrwxrwx. 1 root root 8  2월 19  2018 /sbin -> usr/sbin

ls -l /usr/bin/userdel
> ls: cannot access /usr/bin/userdel: 그런 파일이나 디렉터리가 없습니다

ls -l /usr/sbin/userdel
> -rwxr-x---. 1 root root 80360 11월  5  2016 /usr/sbin/userdel
```
- bin 에서 userdel 을 찾았을때 에러가 발생하는지 파일을 찾을수 있는지 확인합니다.
- system admin 명령은 일반적으로 sbin 디렉토리에서 찾을 수 있습니다.
- 모든 사용자가 실행할 수 있는 일반 명령은 bin 디렉토리에서 찾을 수 있습니다.

```sh
find / -name userdel
```

`find` 명령으로 찾을수있지만 권한 오류가 많이 발생합니다.
### 해결 방법
1. 모든 오류 메시지를 dev null로 보내는 것입니다. 그래서 우리는 그것들을 볼 필요가 없습니다.

```sh
find / -name userdel 2>/dev/null
>
/home/vagrant/userdel
/usr/sbin/userdel
/usr/share/bash-completion/completions/userdel
```
- 이제 오류 메시지가 dev null로 리디렉션되었기 때문에 화면에 표시되지 않습니다.
- 리디렉션된 에러를 제외한 `userdel` 이름과 일치하는 항목이 모두 남습니다.

2. sudo 를 사용

우리가 찾고 있는 파일이 실제로 루트 권한이 필요한 어딘가에 있다면 어떨까요?
이 특별한 경우에는 `sudo` 명령을 루트로 실행하려고 합니다.

```sh
sudo find / -name userdel
>
/home/vagrant/userdel
/usr/sbin/userdel
/usr/share/bash-completion/completions/userdel
```

## 32. Deleting and Disabling Linux Accounts, Part 2 of 4 (The userdel command)
> userdel 을 사용해서 사용자를 삭제하는 방법을 배웁니다.
- `-r` 옵션으로 홈디렉토리까지 삭제

### 참고
- [userdel](/QuickReferences/SHELL_COMMAND.md#userdel)

## 33. Deleting and Disabling Linux Accounts, Part 3 of 4 (Archives with tar)
> 필요할 경우를 대비하여 사용자의 홈 디렉토리를 보관하거나 저장하는 방법을 알아보겠습니다.

이를 수행하는 한 가지 방법은 `tar` 명령을 사용하는 것입니다.

`tar` 명령은 원래 테이프 아카이브를 의미했지만 테이프뿐만 아니라 모든 저장 장치에 파일을 아카이브하는 데 사용할 수도 있습니다.

### `taz` 압축 및 해제

### tgz 압축
```sh
[vagrant@localuser ~]$ tar -zcvf catvideos.tgz catvideos/ 
catvideos/
catvideos/padme-amikitty.mp4
catvideos/darthpaw.mp4
catvideos/admiral-catbar.mp4
catvideos/luke-claw-walker.mp4
catvideos/obi-wan-catnobi.mp4

[vagrant@localuser ~]$ ll
합계 8
drwxrwxr-x 2 vagrant vagrant 4096  1월 29 05:38 catvideos
-rw-rw-r-- 1 vagrant vagrant  262  1월 29 05:40 catvideos.tgz
-rw-rw-r-- 1 vagrant vagrant    0  1월 28 06:40 userdel
```

### gzip 압축해제
```sh
[vagrant@localuser ~]$ mkdir restore
[vagrant@localuser ~]$ cd restore/
[vagrant@localuser restore]$ tar -zxvf ../catvideos.tgz 
catvideos/
catvideos/padme-amikitty.mp4
catvideos/darthpaw.mp4
catvideos/admiral-catbar.mp4
catvideos/luke-claw-walker.mp4
catvideos/obi-wan-catnobi.mp4

[vagrant@localuser restore]$ ls -l
합계 4
drwxrwxr-x 2 vagrant vagrant 4096  1월 29 05:38 catvideos

[vagrant@localuser restore]$ ls -l catvideos/
합계 0
-rw-rw-r-- 1 vagrant vagrant 0  1월 29 05:37 admiral-catbar.mp4
-rw-rw-r-- 1 vagrant vagrant 0  1월 29 05:37 darthpaw.mp4
-rw-rw-r-- 1 vagrant vagrant 0  1월 29 05:38 luke-claw-walker.mp4
-rw-rw-r-- 1 vagrant vagrant 0  1월 29 05:38 obi-wan-catnobi.mp4
-rw-rw-r-- 1 vagrant vagrant 0  1월 29 05:38 padme-amikitty.mp4
```

권한이 있는지 확인하려면 먼저 sudo를 사용하거나 루트 사용자가 되어야 합니다.
예를 들어 시스템의 거의 모든 구성 파일이 들어 있는 `/etc` 디렉토리의 내용을 백업한다고 가정해 보겠습니다.

`/etc`에는 일반 사용자가 액세스할 수 없는 일부 파일이 있기 때문에 루트 권한이 필요합니다.

이제 홈 디렉토리로 돌아가 sudo tar -z를 수행해 봅시다.

```sh
[vagrant@localuser ~]$ sudo tar -zcf etc.tgz /etc
tar: Removing leading `/' from member names
```
- `tar`는 멤버 이름에서 선행 슬래시를 제거한다고 말합니다.

예를 들어, 이것을 다른 하위 디렉토리로 추출한 다음 해당 아카이브 또는 해당 백업과 해당 아카이브 또는 해당 백업을 현재 있는 것과 바로 비교하는 대신 해당 아카이브 또는 해당 백업의 내용을 현재 디스크에 있는 것과 비교하고 싶을 수 있습니다.

여기에서 `tar`는 선행 슬래시로 표시된 절대 경로를 제거하고 아카이브 내 상대 경로를 남길 것입니다.
```sh
[vagrant@localuser ~]$ tar zcvf catvideos.tgz catvideos/
catvideos/
catvideos/padme-amikitty.mp4
catvideos/darthpaw.mp4
catvideos/admiral-catbar.mp4
catvideos/luke-claw-walker.mp4
catvideos/obi-wan-catnobi.mp4
```
- 옵션 앞에 `-` 를 생략해도 사용 할수 있습니다.
- 이것은 오늘날까지도 여전히 지원되는 오래된 유형의 구문입니다.
- 오래된 유형의 구문을 사용하면 다소 혼란스러워지므로 tar를 다른 구문과 동일하게 취급하십시오.


## 34. Deleting and Disabling Linux Accounts, Part 4 of 4 (Disabling Accounts)
> 계정을 실제로 삭제하지 않고 비활성화하거나 잠그는 방법에 대해 알아보겠습니다.

장기 휴가를 가거나 결근하는 사람이 있다고 가정해 보겠습니다.
그들이 돌아올 때 자신의 계정을 사용하기를 원합니다.
그러나 시스템에 존재하는 모든 계정에 대해 누군가 해당 계정에 침입할 가능성이 있다는 것도 알고 있습니다.
이 사람은 오랫동안 자리를 비울 것이기 때문에 계정에 액세스할 수 없는 사람이 계정을 사용하고 있는지 아무도 실제로 알아차리지 못할 수 있습니다.
따라서 보안상의 이유로 해당 계정을 잠그기로 결정했다고 가정해 보겠습니다.

이를 수행하는 가장 좋은 방법은 실제로 `chage` 명령을 사용하거나 연령을 변경하는 것입니다.

### chage 를 사용해서 사용자 계정 만료 설정 및 해제

**계정 만료 설정**
```sh
[vagrant@localuser ~]$ su woz
암호:
[woz@localuser vagrant]$ 

[woz@localuser vagrant]$ exit
exit

[vagrant@localuser ~]$ sudo chage -E 0 woz

[vagrant@localuser ~]$ su - woz
암호:
계정이 만료되었습니다: 시스템 관리자에게 알려 주십시오
su: 사용자 계정 만료
[vagrant@localuser ~]$ 
```
- `sudo chage -E 0 woz` 만료시점을 0으로 설정
- 이후 로그인시 계정이 만료되었습니다 만료 메시지 표시

**계정 만료 해제**
```sh
[vagrant@localuser ~]$ sudo chage -E -1 woz

[vagrant@localuser ~]$ su - woz
암호:
마지막 로그인: 일  1월 29 07:00:54 EST 2023 일시 pts/0
마지막 로그인 실패: 일  1월 29 07:04:30 EST 2023 일시 pts/0 
마지막 로그인 후 1 번의 로그인 시도가 실패하였습니다.  
```
- `sudo chage -E -1 woz` 만료시점을 -1로 변경해서 해제

### 계정잠금
계정을 잠그는 일부 오래된 방법에는 `-l` 옵션을 사용하여 이와 같은 암호를 입력하는 것이 포함됩니다.

passwd는 계정을 잠그고 잠금을 해제하려면 계정 이름에 대해 암호를 사용하면 됩니다.

```sh
[vagrant@localuser ~]$ sudo passwd -l woz
woz 사용자의 비밀 번호 잠금
passwd: 성공

[vagrant@localuser ~]$ sudo passwd -u woz
woz 사용자의 비밀 번호 잠금 해제 중
passwd: 성공
```

이제 이와 같은 암호 명령으로 계정을 잠그더라도 사용자가 `ssh` 키로 인증하는 것을 막지 않습니다.
특히 `ssh` 키를 기본 인증 방법으로 점점 더 많이 사용하고 있기 때문에 이는 알아야 할 매우 중요합니다.
따라서 `ssh` 키를 전혀 사용하지 않는 경우 이는 수행할 것이라고 생각하는 작업을 수행하지 않습니다.

이렇게 사용하는 대신 `chage`를 사용하십시오.

또 다른 방법은 쉘을 실제로 쉘이 아닌 것으로 설정하거나 단순히 시스템에서 사용 가능한 쉘을 보기 위해 종료하는 것으로 설정하는 것입니다.

`/etc/shells` 파일을 볼 수 있으므로 `/etc/shells`에서 이를 수행하고 여기서 로그인 사용자 및 로그 없음을 볼 수 있습니다. 그리고 이론적으로 누군가가 로그인하는 것을 방지합니다.

usermod 명령으로 로그인을 알 수 있도록 woz user의 쉘을 설정합니다.
```sh
[vagrant@localuser ~]$ sudo usermod -s /sbin/nologin woz
```
- `-s`는 셸을 지정하고 로그인을 알리고 이를 설정합니다.
- 쉘로 설정하면 시스템에서 즉시 로그아웃됩니다.

방금 설명한 것처럼 대화형 로그인에 대해 작동하지만 대화형 로그인이 필요하지 않거나 포트 포워딩과 같은 셸이 필요하지 않은 `SSH`를 사용하여 여전히 일부 작업을 수행할 수 있습니다.

따라서 다시 `-E 0` 옵션이 있는 `chage` 명령을 사용하여 실제로 계정을 비활성화합니다.

우리는 오늘 여기 명령줄에서 많은 시간을 보냈습니다. 그래서 오늘 본 것 중 일부를 사용하여 사용자 계정을 삭제하는 빠른 셸 스크립트를 작성해 봅시다.

```sh
[vagrant@localuser vagrant]$ tail -1 /etc/passwd
good:x:1004:1005:hello my name is good:/home/good:/bin/bash

[vagrant@localuser vagrant]$ sudo ./luser-demo12.sh good
The account good was deleted.

[vagrant@localuser vagrant]$ id good
id: good: no such user

[vagrant@localuser vagrant]$ sudo ./luser-demo12.sh good
userdel: 'good' 사용자가 없습니다
The account good was NOT deleted.
```

### 참고
- [chage](/QuickReferences/SHELL_COMMAND.md#chage)
- [Script](./luser-demo12.sh)