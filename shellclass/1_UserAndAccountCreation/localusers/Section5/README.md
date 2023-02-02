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