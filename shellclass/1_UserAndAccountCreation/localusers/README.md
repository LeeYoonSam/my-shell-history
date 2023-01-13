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
- [luser-demo04.sh](./luser-demo04.sh)

# Password Generation and ShellScript Arguments

## 18. Random Data, Cryptographic Hash Functions, Text and String Manipulation.
> 랜덤 데이터, 암호화 해시 함수, 텍스트 및 문자열 조작.

**배울 내용**
- 임의의 데이터를 생성하는 몇 가지 다른 방법
- 임의 암호 생성 프로세스를 자동화하는 방법
    - 사용자의 입력을 덜 요구하여 스크립트를 개선

### 참고
- [luser-demo05.sh](./luser-demo05.sh)

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
- [luser-demo06.sh](./luser-demo06.sh)

## 20. The while Loop, Infinite Loops, Shifting, Sleeping

**배울 내용**
- 위치 매개변수를 계속 탐색하고 While loop 생성하는 방법

### shift
- `shift` 명령이 실제로 수행하는 작업은 목록에서 위치 매개변수를 `$1`로 제거하는 것입니다.
- `$2`에 저장된 값이 `$1` `$3`으로 이동합니다.
- `${}` 의 특수 매개 변수가 1씩 줄어듭니다.
- `while` 루프가 처음 실행되고 `shift`가 실행되면 매개변수의 수가 줄어듭니다.


# Conventions

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