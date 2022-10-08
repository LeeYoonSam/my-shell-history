# [Philosophy(철학)](https://www.shellscript.sh/philosophy.html)

좋고, 깨끗하고, 빠른 쉘 스크립트에 들어갈 수 있는 많은 요소가 있습니다. 
- 가장 중요한 기준은 명확하고 읽기 쉬운 레이아웃이어야 합니다. 
- 두 번째는 불필요한 명령을 피하는 것입니다.

</br>

명확한 레이아웃은 "블랙 매직"으로 나타나는 쉘 스크립트와 쉽게 유지 관리되고 이해되는 쉘 스크립트를 구별합니다.

간단한 스크립트에서는 이것이 그다지 심각한 문제가 아니라고 생각할수 있지만 여기서 두 가지를 염두해야 할것이 있습니다.
1. 첫째, 단순한 스크립트가 예상보다 더 자주 크고 복잡한 스크립트로 성장할 것입니다.
2. 둘째, 다른 사람이 작동 방식을 이해할 수 없다면 평생 동안 스스로 유지 관리해야 합니다!

셸 스크립트에 대한 무언가가 특히 들여쓰기가 심하게 될 가능성이 있는 것으로 보이며, 주요 제어 구조는 `if/then/else/loop` 이므로 들여쓰기는 스크립트가 하는 일을 이해하는 데 중요합니다.

### 예시
셸 스크립트의 약점
```shell
cat /tmp/myfile | grep "mystring"
```

다음과 같이 훨씬 빠르게 실행됩니다.
```shell
grep "mystring" /tmp/myfile
```

- OS는 시스템에서 상당히 작은 75600바이트인 /bin/grep 실행 파일을 로드해야 합니다.
- 전송을 위해 메모리에서 파이프를 열고 내 시스템에서 훨씬 더 작은 9528바이트인 /bin/cat 실행 파일을 로드 및 실행하고 파이프의 입력에 연결하고 실행합니다.
- 이 명령이 여러 번 실행되는 루프에 있는 경우 cat 실행 파일을 찾아 로드하지 않고 파이프를 설정하고 해제하는 것을 절약하면 특히 다른 항목이 충분히 있는 CGI 환경에서 약간의 차이를 만들 수 있습니다. 스크립트 자체가 너무 많은 장애물 없이 작업을 느리게 만드는 요소입니다.
- 일부 Unices는 "프로세스 구축 및 해체"(예: 로드, 실행 및 다시 지우기)에서 다른 Unices보다 더 효율적입니다.

---

## 용어 및 명령어 정리

### pipeline
> 파이프라인은 제어 연산자 '|' 또는 '|&' 중 하나로 구분된 하나 이상의 명령 시퀀스입니다. 

파이프라인 형식은 다음과 같습니다.
```shell
[time [-p]] [!] command1 [ | or |& command2 ] …
```
- 파이프라인에 있는 각 명령의 출력은 파이프를 통해 다음 명령의 입력에 연결됩니다. 즉, 각 명령은 이전 명령의 출력을 읽습니다. 이 연결은 command1에 의해 지정된 리디렉션 전에 수행됩니다.
- '|&'를 사용하면 command1의 표준 오류와 표준 출력이 파이프를 통해 command2의 표준 입력에 연결됩니다. 2>&1 |의 줄임말입니다. 표준 출력에 대한 표준 오류의 암시적 리디렉션은 command1에 의해 지정된 리디렉션 후에 수행됩니다.
- 예약어 `time`은 파이프라인이 완료되면 타이밍 통계가 인쇄되도록 합니다. 현재 통계는 경과(벽시계) 시간과 명령 실행에 사용된 사용자 및 시스템 시간으로 구성됩니다.
- `-p` 옵션은 출력 형식을 POSIX에서 지정한 형식으로 변경합니다. 쉘이 POSIX 모드(Bash POSIX 모드 참조)에 있을 때 다음 토큰이 '-'로 시작하면 시간을 예약어로 인식하지 않습니다.
- `time`을 예약어로 사용하면 쉘 내장, 쉘 기능 및 파이프라인의 타이밍이 허용됩니다. 외부 시간 명령은 이러한 시간을 쉽게 측정할 수 없습니다.
- 파이프라인이 비동기식으로 실행되지 않으면(명령 목록 참조) 셸은 파이프라인의 모든 명령이 완료될 때까지 기다립니다.
- 파이프가 생성되는 다중 명령 파이프라인의 각 명령은 별도의 프로세스인 자체 서브쉘에서 실행됩니다(명령 실행 환경 참조). 마지막 파이프 옵션이 shopt 내장 기능을 사용하여 활성화된 경우(The Shopt 내장 참조) 작업 제어가 활성화되지 않은 경우 파이프라인의 마지막 요소가 셸 프로세스에 의해 실행될 수 있습니다.
- 파이프라인의 종료 상태는 pipefail 옵션이 활성화되지 않는 한 파이프라인의 마지막 명령의 종료 상태입니다. 
- pipefail이 활성화된 경우 파이프라인의 반환 상태는 0이 아닌 상태로 종료되는 마지막(가장 오른쪽) 명령의 값이거나 모든 명령이 성공적으로 종료되면 0입니다. 
- 예약어 `!`가 파이프라인 앞에 있으면 종료 상태는 위에서 설명한 종료 상태의 논리적 부정입니다. 
- 셸은 값을 반환하기 전에 파이프라인의 모든 명령이 종료될 때까지 기다립니다.
</br>

- [Bash Reference Manual - Pipelines](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Pipelines)

### cat
> cat 명령은 여러 파일의 내용을 연결하고 결과를 표준 출력에 표시합니다.

```shell
cat file1 [files]
```

**Example**
Example 1 - 파일 내용을 표준 출력으로 표시:
```shell
$ cat /etc/passwd
```

Example 2 - 여러 파일의 내용을 표준 출력으로 표시:
```shell
$ cat /etc/passwd /etc/group
```

Example 3 - 출력 리디렉션을 사용하여 여러 파일의 내용을 하나의 파일로 결합:
```shell
$ cat /etc/passwd /etc/group > usersAndGroups.txt
```

Example 4 - 줄 번호 표시:
```shell
$ cat -n /etc/profile
     1    # /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
     2    # and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).
     3
     4    if [ "`id -u`" -eq 0 ]; then
     5      PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
     6    else
…
```

Example 5 - 비어 있지 않은 줄의 번호를 표시합니다:
```shell
$ cat -b /etc/profile
     1    # /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
     2    # and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

     3    if [ "`id -u`" -eq 0 ]; then
     4      PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
     5    else
…
```

### grep
> grep 명령은 파일에서 문자열을 검색합니다.

```shell
grep [-w] [-i] [-v] "string" file
```

**Example**
```shell
$ grep -w "root:" /etc/passwd
root:x:0:0:root:/root:/bin/bash
```

| Option | Description |
| --- | --- |
| -i | 검색된 문자열의 대소문자를 무시합니다. |
| -v | 문자열을 포함하는 행을 제외합니다. |
| -w | 정확한 단어를 검색하세요. |

</br>

grep 명령은 찾고 있는 문자열이 포함된 전체 줄을 반환합니다. `^`는 줄의 시작 부분에서 문자열을 검색하는 데 사용됩니다. `$`는 줄 끝에서 문자열을 검색합니다.

```shell
$ grep -w "^root" /etc/passwd
```

`-R` 옵션을 사용하여 파일 트리에서 문자열을 검색할 수 있습니다.

```shell
$ grep -R "Virtual" /etc/httpd
```