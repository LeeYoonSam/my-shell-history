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
- [Script](../luser-demo13.sh)


# 39. Sort and Uniq

**배울 내용**
- `sort`, `unique commands` 를 사용하여 데이터를 정렬하는 방법

파일 내용을 사전순으로 정렬하려면 sort 명령을 사용할 수 있습니다.

이전 레슨에서 `netstat` 명령을 사용하여 열린 포트를 표시하는 부분을 다시 살펴보겠습니다.

```sh
[vagrant@localuser ~]$ netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -nu
22
25
68
323
25480
42484
```
- `sort -nu` 를 사용해서 유니크한 값만 출력되도록 정렬

```sh
[vagrant@localuser ~]$ netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq
22
25
68
323
25480
42484
```
- sort -n | uniq 를 사용해서 유니크한 값을 출력 할수도 있습니다.

```sh
[vagrant@localuser ~]$ netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | uniq
22
25
22
25
42484
323
68
25480
323
```
- 연속된 값을 기준으로 처리하기 때문에 uniq 는 정렬이 된 상태로 사용해야 정상적으로 작동합니다.

**uniq -c 옵션으로 몇번 중복되었는지 표시**
```sh
[vagrant@localuser ~]$ netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c
      2 22
      2 25
      1 68
      2 323
      1 25480
      1 42484
```
- 첫 번째 열은 행이 출력에 나타난 횟수이고 그 다음에는 행 또는 출력 자체가 옵니다.

프로그램이 생성하는 syslog 메시지의 수를 알고 싶다고 가정하고 다음과 같은 작업을 수행할 수 있습니다.
```sh
sudo cat /var/log/messages
Jan 29 06:32:01 localuser rsyslogd: [origin software="rsyslogd" swVersion="8.24.0" x-pid="610" x-info="http://www.rsyslog.com"] rsyslogd was HUPed
Jan 29 06:32:05 localuser systemd: Removed slice User Slice of root.
Jan 29 06:32:05 localuser systemd: Stopping User Slice of root.
Jan 29 07:00:54 localuser su: (to woz) vagrant on pts/0
Jan 29 07:01:01 localuser systemd: Created slice User Slice of root.
...
```
- 다섯 번째 필드에는 애플리케이션 이름 또는 Syslog에 기록 중인 프로그램 이름이 포함됩니다.

```sh
[vagrant@localuser ~]$ sudo cat /var/log/messages | awk '{print $5}'
rsyslogd:
systemd:
systemd:
su:
systemd:
...
```
- 5번째 필드만 출력

```sh
[vagrant@localuser ~]$ sudo cat /var/log/messages | awk '{print $5}' | sort | uniq -c
     58 NetworkManager[627]:
     58 NetworkManager[629]:
     58 NetworkManager[631]:
      8 chronyd[624]:
      8 chronyd[626]:
     11 chronyd[631]:
     12 dbus-daemon:
      4 dbus[619]:
      4 dbus[620]:
      4 dbus[621]:
      5 dhclient[686]:
      5 dhclient[707]:
      5 dhclient[712]:
     18 journal:
      6 kdumpctl:
   1067 kernel:
   ...
```
- `sort` 로 정렬하고 `uniq -c` 로 중복을 제거하고 몇번 중복되었는지 표시

bash 셸을 사용하는 계정 수를 알고 싶다고 가정해 보겠습니다.

먼저 grep 명령을 사용하여 패턴 bash와 일치하는 줄을 표시할 수 있습니다.
```sh
[vagrant@localuser ~]$ grep bash /etc/passwd
root:x:0:0:root:/root:/bin/bash
vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
yoonsam:x:1001:1002:Lee Yoon Sam:/home/yoonsam:/bin/bash
nice:x:1002:1003::/home/nice:/bin/bash
```

시스템에 수백 개의 계정이 있고 그 순간 시각적으로 보고 인식할 수 있는 것보다 훨씬 더 많은 출력이 있다고 가정해 보겠습니다.

그런 다음 원하는 것은 WC가 출력의 줄 수를 계산하도록 하는 것입니다.

`grep` 명령과 `wc -l` 옵션을 사용하여 라인수를 출력 합니다.
```sh
[vagrant@localuser ~]$ grep bash /etc/passwd | wc -l
4
```

`grep -c` 를 사용해서 일치하는 행의 수를 출력합니다.
```sh
[vagrant@localuser ~]$ grep -c bash /etc/passwd
4
```

특정 URL을 몇 번이나 방문했는지 알고 싶다고 가정해 보겠습니다.
```sh
[vagrant@localuser vagrant]$ cat access_log
29.48.17.65 - - [21/Dec/2017:10:19:53 -0800] "GET /apps/cart.jsp?appID=8345 HTTP/1.0" 200 5040 "http://www.mcdermott.com/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/5360 (KHTML, like Gecko) Chrome/13.0.853.0 Safari/5360"
140.181.105.145 - - [21/Dec/2017:10:21:55 -0800] "GET /posts/posts/explore HTTP/1.0" 200 5017 "http://rempel.com/author/" "Mozilla/5.0 (compatible; MSIE 5.0; Windows NT 5.2; Trident/4.1)"
...
```
- 액세스 로그에 " 안에 url 이 포함되어 있습니다.

```sh
[vagrant@localuser vagrant]$ cut -d '"' -f 2 access_log 
GET /apps/cart.jsp?appID=8345 HTTP/1.0
GET /posts/posts/explore HTTP/1.0
GET /explore HTTP/1.0
DELETE /posts/posts/explore HTTP/1.0
...
```
- " 을 구분자로 나누고 2번째 필드를 출력
- 이제 하나의 공백으로 구분된 세 개의 데이터 열이 남아 있는 것처럼 보입니다.

두 번째 열에는 URL이 있으며 잘라내기 명령으로도 이 작업을 수행할 수 있도록 이를 빼내겠습니다.
```sh
[vagrant@localuser vagrant]$ cut -d '"' -f 2 access_log | cut -d ' ' -f 2
/apps/cart.jsp?appID=8345
/posts/posts/explore
/explore
/posts/posts/explore
...
```

### awk 를 사용해서 똑같은 출력 만들기
```sh
[vagrant@localuser vagrant]$ awk '{print $7}' access_log 
/apps/cart.jsp?appID=8345
/posts/posts/explore
/explore
/posts/posts/explore
/wp-admin
...
```

이제 각 URL이 방문한 횟수를 세고 싶습니다.
`uniq` 명령으로 그렇게 할 수 있다는 것을 알고 있습니다. 그리고 먼저 정렬된 고유한 데이터를 제공해야 한다는 것도 알고 있습니다.

```sh
[vagrant@localuser vagrant]$ cut -d '"' -f 2 access_log | cut -d ' ' -f 2 | sort | uniq -c
   1229 /app/main/posts
      1 /apps/cart.jsp?appID=10000
      1 /apps/cart.jsp?appID=1003
      1 /apps/cart.jsp?appID=1005
      1 /apps/cart.jsp?appID=1015
      ...
```
- sort 로 정렬하고 uniq -c 로 호출횟수를 표시합니다.

```sh
[vagrant@localuser vagrant]$ cut -d '"' -f 2 access_log | cut -d ' ' -f 2 | sort | uniq -c | sort -n
      1 /apps/cart.jsp?appID=10000
      1 /apps/cart.jsp?appID=1003
      1 /apps/cart.jsp?appID=1005
      ...
```

이제 가장 많이 방문한 상위 3개의 URL만 표시하고 싶다고 가정해 보겠습니다.
```sh
[vagrant@localuser vagrant]$ cut -d '"' -f 2 access_log | cut -d ' ' -f 2 | sort | uniq -c | sort -n | tail -3
   1259 /posts/posts/explore
   1265 /explore
   1271 /wp-admin
```

### 참고
- [sort](/QuickReferences/SHELL_COMMAND.md#sort---정렬)
- [du](/QuickReferences/SHELL_COMMAND.md#du---디스크-사용량)
- [uniq](/QuickReferences/SHELL_COMMAND.md#uniq---중복-제거)
- [Script](../luser-demo14.sh)