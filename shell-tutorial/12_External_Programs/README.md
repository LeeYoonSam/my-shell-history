# 12. External Programs

> 외부 프로그램은 종종 쉘 스크립트 내에서 사용됩니다. <br/>
> 몇 가지 내장 명령(echo, which 및 test는 일반적으로 내장됨)이 있지만 유용한 명령은 tr, grep, expr 및 cut과 같은 Unix 유틸리티입니다.

### 백틱(`)
> 백틱(`)은 종종 외부 명령과 연결됩니다. 이 때문에 우리는 백틱에 대해 먼저 논의할 것입니다.

백틱은 포함된 텍스트가 명령으로 실행될 것임을 나타내는 데 사용됩니다. 이것은 이해하기 매우 간단합니다. 먼저 대화식 셸을 사용하여 `/etc/passwd`에서 전체 이름을 읽습니다.

```shell
$ grep "^${USER}:" /etc/passwd | cut -d: -f5
Steve Parker
```
- 이제 이 출력을 더 쉽게 조작할 수 있는 변수로 가져옵니다.

```shell
$ MYNAME=`grep "^${USER}:" /etc/passwd | cut -d: -f5`
$ echo $MYNAME
Steve Parker
```
그래서 우리는 백틱이 단순히 우리가 실행하기로 선택한 모든 명령 또는 명령 세트의 표준 출력을 포착한다는 것을 알 수 있습니다. 

느린 명령이나 명령 집합을 실행하고 다양한 출력 비트를 구문 분석하려는 경우 성능을 향상시킬 수도 있습니다.

```shell
#!/bin/sh
find / -name "*.html" -print | grep "/index.html$"
find / -name "*.html" -print | grep "/contents.html$"
```
- 이 코드는 실행하는 데 오랜 시간이 걸릴 수 있으며 두 번 수행합니다! 

더 나은 솔루션은 다음과 같습니다.

```shell
#!/bin/sh
HTML_FILES=`find / -name "*.html" -print`
echo "$HTML_FILES" | grep "/index.html$"
echo "$HTML_FILES" | grep "/contents.html$"
```
- 참고: `$HTML_FILES` 주위의 따옴표는 나열된 각 파일 사이의 줄 바꿈을 유지하는 데 필수적입니다. 그렇지 않으면 grep은 파일당 한 줄이 아닌 거대한 긴 텍스트 줄을 보게 됩니다.

이런 식으로 느린 찾기를 한 번만 실행하여 스크립트 실행 시간을 대략 절반으로 줄입니다.

이 자습서의 [힌트 및 팁 섹션](https://www.shellscript.sh/hints.html)에서 특정 예에 대해 자세히 설명합니다.

---

## 명령어

### grep
> 리눅스에서 `grep` 명령어는 특정 파일에서 지정한 문자열이나 정규표현식을 포함한 행을 출력해주는 명령어입니다. <br/>
> 특히 `tail`이나 `ls` 등 다양한 명령어와 조합하여 응용되는 경우가 많아서 이 `grep`명령어는 리눅스에서 능숙하게 사용할 줄 알아야 하는 기본 명령어입니다.

```shell
grep [옵션][패턴][파일명]
```

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

**자주사용하는 옵션**
```
-c : 일치하는 행의 수를 출력한다.
-i : 대소문자를 구별하지 않는다.
-v : 일치하지 않는 행만 출력한다.
-n : 포함된 행의 번호를 함께 출력한다.
-l : 패턴이 포함된 파일의 이름을 출력한다.
-w : 단어와 일치하는 행만 출력한다.
-x : 라인과 일치하는 행만 출력한다.
-r : 하위 디렉토리를 포함한 모든 파일에서 검색한다.
-m 숫자 : 최대로 표시될 수 있는 결과를 제한한다.
-E : 찾을 패턴을 정규 표현식으로 찾는다.
-F : 찾을 패턴을 문자열로 찾는다.
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

## [cut](https://www.lesstif.com/lpt/linux-cut-93127007.html)
> cut 명령어는 file 이나 표준 입력에서 받은 문자열을 잘라내서 새로운 문자열을 만드는 명령어입니다.  

| 옵션 | 의미 | 
| --- | --- | 
| -b, --bytes | 바이트를 기준으로 잘라냅니다. |
| -c, --characters | 문자열을 기준으로 잘라냅니다. |
| -d, --delimiter |	지정한 문자를 구분자로 사용합니다. (기본 TAB) |
| -f, --fields	| 필드를 기준으로 잘라냅니다.	|
| -z, --zero-terminated |	라인의 구분자를 개행문자가 아닌 NUL 을 사용합니다. |

### 문자열로 잘라 만들기

**sample.txt**
```
unix is great os. unix is opensource. unix is free os.
learn operating system.
unix linux which one you choose.
unix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
```

-c 옵션을 사용하면 character 기준으로 잘라 만들수 있습니다. 아래는 각 라인의 2번째 문자부터 4번째 문자까지만 잘라서 새로운 문자열로 출력합니다.
```shell
$ cut -c 2-4 < sed-example.txt

nix
ear
nix
nix
```

숫자 앞 뒤에 하이픈(-)을 붙여서 범위를 지정할 수 있습니다. 아래는 10 번째 글자 이후만 잘라서 출력합니다.

```shell
$ cut -c 10- < sed-example.txt   

reat os. unix is opensource. unix is free os.
rating system.
x which one you choose.
asy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
```

아래는 맨 앞의 6자까지만 출력합니다.
```shell
$ cut -c -6 < sed-example.txt

unix i
learn 
unix l
unix i
```

특정 위치의 값만 잘라올 경우 , 로 구분자로 해서 위치를 지정해 줍니다.
```shell
$ cut -c 2,5,7 < sed-example.txt

n s
eno
n i
n s
```

### delimiter 지정
-d 옵션으로 구분자를 지정할 수 있습니다. -d 옵션을 사용할 경우 -c 나 -b 는 사용할 수 없고 필드를 지정하는 옵션인 -f 만 사용해야 합니다.

/etc/passwd 파일의 구분자는 : 이므로 아래는 시스템에 등록된 사용자의 id 를 표시합니다.

```shell
$ cut  -d ':' -f 1 /etc/passwd

sshd
chrony
ec2-user
apache
nginx
```

아래 명령어는 사용자의 이름을 표시합니다.
```shell
$ cut  -d ':' -f5 /etc/passwd

Cloud User
Apache
Nginx web server
```

-f 는 , 를 구분자로 여러 필드를 추출할 수 있으며 아래는 사용자의 id와 shell 을 표시합니다.

```shell
$ cut  -d ':' -f1,7  /etc/passwd

ec2-user:/bin/bash
apache:/sbin/nologin
nginx:/sbin/nologin
pcp:/sbin/nologin
```

### 참고
- [[Linux] 리눅스 grep 명령어 사용법 (파일 내 특정 문자열 찾기)](https://coding-factory.tistory.com/802)

- https://www.geeksforgeeks.org/cut-command-linux-examples/
- https://jhnyang.tistory.com/145