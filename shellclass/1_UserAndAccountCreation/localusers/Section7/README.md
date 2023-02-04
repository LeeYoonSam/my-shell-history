# Section 7: Transforming Data / Data Processing / Reporting

## 37. Cut and AWK

**배울 내용**
- cut 명령으로 section 을 추출하는 방법
- 바이트, 문자 및 필드를 기반으로 자르는 방법
- CSV 파일, 암호 파일 및 열로 구성된 기타 유형의 데이터로 쉽게 작업할 수 있도록 구분 기호를 지정하는 방법
- ^(당근) 및 $(달러 기호) 앵커 정규식에 대해 배웠고 grep 명령과 함께 사용했습니다.
- `awk`와 다중 문자를 처리하는 방법

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


## 38. Cut and Awk Demonstration Script: Open Network Ports
추가 데이터 없이 로컬 시스템에서 열려 있는 포트 번호 목록을 원한다고 가정해 보겠습니다. 번호 22만 표시되기를 원합니다.

예를 들어 포트 22에 SSH 목록이 있는 경우 net stat 명령은 열린 포트를 표시할 수 있으며 그에 대한 매뉴얼 페이지를 표시하는 대신 사용할 옵션을 안내해 드리겠습니다.

`net stat` 명령을 사용하고 대시 입력 옵션을 사용하여 이름 대신 숫자를 표시합니다.
따라서 SSH 또는 SSHD를 표시하는 대신 22를 표시합니다.

포트 22의 경우 `u`를 사용하여 UDP에 대한 정보를 얻고 `t`를 사용하여 TCP에 대한 정보를 얻고 `l`을 사용해서 리스닝 포트에 대한 정보를 얻습니다.

따라서 해당 명령을 실행하면 다음과 같은 결과가 나타납니다.

```sh
[vagrant@localuser vagrant]$ netstat -nutl
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
tcp6       0      0 ::1:25                  :::*                    LISTEN     
udp        0      0 0.0.0.0:38246           0.0.0.0:*                          
udp        0      0 127.0.0.1:323           0.0.0.0:*                          
udp        0      0 0.0.0.0:68              0.0.0.0:*                          
udp6       0      0 :::51852                :::*                               
udp6       0      0 ::1:323                 :::*         
```

이 특별한 경우에는 헤더를 구성하는 두 줄이 있습니다.
따라서 이를 관리하는 몇 가지 방법이 있습니다.

한 가지 방법은 그것을 grep으로 파이프하고 grep dash V를 수행하는 것입니다.
```sh
[vagrant@localuser vagrant]$ netstat -nutl | grep -v '^Active'
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
tcp6       0      0 ::1:25                  :::*                    LISTEN     
udp        0      0 0.0.0.0:38246           0.0.0.0:*                          
udp        0      0 127.0.0.1:323           0.0.0.0:*                          
udp        0      0 0.0.0.0:68              0.0.0.0:*                          
udp6       0      0 :::51852                :::*                               
udp6       0      0 ::1:323                 :::*                               
[vagrant@localuser vagrant]$ 
```
- 첫 번째 줄을 제거합니다.

그런 다음 grep을 다시 사용하여 이 작업을 계속할 수 있고 이와 같이 두 번째 줄을 제거할 수 있습니다.
```sh
[vagrant@localuser vagrant]$ netstat -nutl | grep -v '^Active' | grep -v '^Proto'
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
tcp6       0      0 ::1:25                  :::*                    LISTEN     
udp        0      0 0.0.0.0:38246           0.0.0.0:*                          
udp        0      0 127.0.0.1:323           0.0.0.0:*                          
udp        0      0 0.0.0.0:68              0.0.0.0:*                          
udp6       0      0 :::51852                :::*                               
udp6       0      0 ::1:323                 :::*        
```

따라서 헤더가 없는 순수한 데이터만 남게 됩니다.

이제 `grep`에서 확장된 정규식을 사용하는 것도 가능합니다.
이제 `grep`에서 `-E` 옵션과 함께 확장된 정규식을 사용하여 이와 같은 작업을 수행할 수 있습니다.

```sh
[vagrant@localuser vagrant]$ netstat -nutl | grep -Ev '^Active|^Proto'
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
tcp6       0      0 ::1:25                  :::*                    LISTEN     
udp        0      0 0.0.0.0:38246           0.0.0.0:*                          
udp        0      0 127.0.0.1:323           0.0.0.0:*                          
udp        0      0 0.0.0.0:68              0.0.0.0:*                          
udp6       0      0 :::51852                :::*                               
udp6       0      0 ::1:323                 :::*                               
```
- `grep` 를 두번 사용하지 않고 확장된 정규식을 사용해서 같은 작업을 수행

이제 우리가 남긴 데이터를 보면 각 행마다 공통되는 것이 있는데,

어떤 줄에는 TCP가 있고, 어떤 줄에는 TCP 6이 있고, 어떤 줄에는 UDP가 있고, 어떤 줄에는 수신이 있고, 어떤 줄에는 숫자가 있습니다.
그러나 여기에서 변하지 않는 한 가지는 콜론입니다.

```sh
[vagrant@localuser vagrant]$ netstat -nutl
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
tcp6       0      0 ::1:25                  :::*                    LISTEN     
udp        0      0 0.0.0.0:38246           0.0.0.0:*                          
udp        0      0 127.0.0.1:323           0.0.0.0:*                          
udp        0      0 0.0.0.0:68              0.0.0.0:*                          
udp6       0      0 :::51852                :::*                               
udp6       0      0 ::1:323                 :::*                               
[vagrant@localuser vagrant]$ netstat -nutl | grep ':'
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
tcp6       0      0 ::1:25                  :::*                    LISTEN     
udp        0      0 0.0.0.0:38246           0.0.0.0:*                          
udp        0      0 127.0.0.1:323           0.0.0.0:*                          
udp        0      0 0.0.0.0:68              0.0.0.0:*                          
udp6       0      0 :::51852                :::*                               
udp6       0      0 ::1:323                 :::*                               
```

따라서 어느 쪽이든 여기서 목표는 헤더 없이 데이터를 가져오는 것입니다.
우리가 추출하려는 데이터가 1행에서 포트이기 때문에 22를 빼내려고 합니다.
두 번째 줄에서 25를 꺼내고 싶습니다. 이것이 해당 포트입니다.
처음에는 이것을 콜론으로 분할하고 두 번째 필드를 인쇄할 수 있다고 생각할 수 있습니다.

따라서 구분 기호로 콜론에 대해 `cut -d` 를 수행하고 두 번째 필드를 인쇄합니다.
```sh
[vagrant@localuser vagrant]$ netstat -nutl | grep ':' | cut -d ':' -f 2
22              0.0.0.0
25            0.0.0.0


38246           0.0.0.0
323           0.0.0.0
68              0.0.0.0


[vagrant@localuser vagrant]$ 
```
- 일부 라인에는 추가 데이터가 있고 다른 라인에는 빈 라인이 있기 때문에 우리가 원하는 것을 정확하게 제공하지 못합니다.
- 여기에서 알 수 있듯이 이 줄에는 세 개의 콜론이 있습니다.

`awk`가 이러한 종류의 공백 상황을 잘 처리한다는 것을 알고 있으므로 이를 사용하여 네 번째 열을 추출할 것입니다.

```sh
[vagrant@localuser vagrant]$ netstat -nutl | grep ':' | awk '{print $4}'
0.0.0.0:22
127.0.0.1:25
:::22
::1:25
0.0.0.0:38246
127.0.0.1:323
0.0.0.0:68
:::51852
::1:323
```
- 추출을 원하는 숫자는 콜론 제일 마지막에 있습니다.

한 경우에는 두 개의 필드가 있고 다른 경우에는 두 개 이상의 필드가 있습니다.
따라서 `awk`를 사용하고 필드 구분 기호로 콜론을 지정합니다.
```sh
[vagrant@localuser vagrant]$ netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'
22
25
22
25
38246
323
68
51852
323
```

이제 돌아가서 여기에서 일반 `net stat` 명령을 실행하면 `TCP` 및 `TCP 6`에서 데이터를 가져오는 것을 볼 수 있습니다.
따라서 TCP V 4, TCP V 6, UDP와 동일합니다.

TCP V 4를 얻을 수 있는 한 가지 방법은 net stat 옵션에 대시를 사용하는 것입니다.

여기서도 grep을 사용하여 일반적인 헤더를 제외하거나 데이터를 포함할 수 있습니다.

```sh
[vagrant@localuser vagrant]$ netstat -4nutl | grep ':' | awk '{print $4}' | cut -d ':' -f 2
22
25
38246
323
68

[vagrant@localuser vagrant]$ netstat -4nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $2}'
22
25
38246
323
68

[vagrant@localuser vagrant]$ netstat -4nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'
22
25
38246
323
68
```

### 참고
-[Script](/shellclass/1_UserAndAccountCreation/localusers/luser-demo13.sh)