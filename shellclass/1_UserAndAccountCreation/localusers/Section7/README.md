# Section 7: Transforming Data / Data Processing / Reporting

## 37. Cut and AWK

**배울 내용**
- 잘라내기 및 명령을 사용하는 방법을 배웁니다. 

`cut` 명령은 수신한 각 입력 라인에서 섹션을 잘라내어 해당 섹션을 표준 출력으로 표시하는데 사용됩니다.

`cut`을 사용하여 바이트 위치, 문자 위치 또는 구분 기호로 줄 조각을 추출할 수 있습니다.


### Example
대부분의 경우에는 문제가 없지만 여러 문자로 분할하고 싶거나 분할해야 하는 경우가 있을 수 있습니다.
```sh
[vagrant@localuser vagrant]$ cut -d ':' -f 2 people.dat
firstDATA
JohnDATA
firstlyDATA
Mr. firstlyDATA

[vagrant@localuser vagrant]$ cut -d 'DATA:' -f 2 people.dat
cut: 구획 문자는 단일 문자여야 합니다
Try 'cut --help' for more information.

[vagrant@localuser vagrant]$ awk -F 'DATA:' '{print $2}' people.dat
first
John
firstly
Mr. firstly
```
- `-F` 옵션을 사용하면 필드 구분 기호를 지정할 수 있습니다.
- 데이터 콜론을 필드 구분 기호로 사용하도록 지시하고 있습니다.

출력 필드 구분 기호는 awk의 공간 입니다.

```sh
[vagrant@localuser vagrant]$ awk -F ':' -v OFS=',' '{print $1, $3}' /etc/passwd
root,0
bin,1
daemon,2
adm,3
lp,4
sync,5
...
```

```sh
awk -F ':' '{print $1 "," $3}' /etc/passwd
root,0
bin,1
daemon,2
adm,3
lp,4
sync,5
...
```

```sh
[vagrant@localuser vagrant]$ awk -F ':' '{print "COL1: " $1 " COL2: " $3}' /etc/passwd
COL1: root COL2: 0
COL1: bin COL2: 1
COL1: daemon COL2: 2
COL1: adm COL2: 3
COL1: lp COL2: 4
COL1: sync COL2: 5
```

```sh
[vagrant@localuser vagrant]$ cut -d ':' -f 3,1 /etc/passwd
root:0
bin:1
daemon:2
adm:3
lp:4
sync:5
...

[vagrant@localuser vagrant]$ awk -F ':' '{print $3, $1}' /etc/passwd
0 root
1 bin
2 daemon
3 adm
4 lp
5 sync
...
```
- `cut` 를 사용하면 순서를 제어 할 수 없습니다.
- `awk` 를 사용하면 순서를 제어 할 수 있습니다.

그런 다음 원하는 다른 추가 문자열과 결합할 수 있습니다.
```sh
[vagrant@localuser vagrant]$ awk -F ':' '{print "UID: "$3 ";Login: " $1}' /etc/passwd
UID: 0;Login: root
UID: 1;Login: bin
UID: 2;Login: daemon
UID: 3;Login: adm
UID: 4;Login: lp
UID: 5;Login: sync
...
```

```sh
[vagrant@localuser vagrant]$ awk -F ':' '{print $NF}' /etc/passwd
/bin/bash
/sbin/nologin
/sbin/nologin
/sbin/nologin
/sbin/nologin
/bin/sync
...

[vagrant@localuser vagrant]$ awk -F ':' '{print $(NF - 1)}' /etc/passwd
/root
/bin
/sbin
/var/adm
/var/spool/lpd
...
```
- `$NF` 를 사용하면 마지막 필드를 얻을 수 있습니다.
- `$(NF - 1)` 뒤에서 2번째 필터를 얻을 수 있습니다.

불규칙한 데이터를 생성해 봅시다.

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


### 참고
- [cut](/QuickReferences/SHELL_COMMAND.md#cut---문자열-조작)
- [awk](/QuickReferences/SHELL_COMMAND.md#awk---문자열-조작)