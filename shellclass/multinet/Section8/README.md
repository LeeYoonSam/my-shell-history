# 43. Configuring a Mini Network and Scripting for Remote Systems

**배울 내용**
- 회사 네트워크를 시뮬레이션 할 수 있는 소규모 가상 머신 네트워크를 만드는 방법
- SSH 키 인증을 구성하고 ssh를 통해 원격 시스템에서 명령을 실행하는 방법

관리자, 서버등의 가상 머신을 여러개 생성.

이러한 유형의 설정은 하나의 서버가 운영의 기반이 되는 기본 관리 서버 역할을 하고, 네트워크에 비즈니스 작업에 사용되는 다른 여러 서버를 두는 매우 일반적인 설정입니다.

웹 서버, 데이터베이스 서버 등이 될 수 있습니다.

## 가상머신 생성
### vagrant init
```sh
vagrant init jasonc/centos7
```

### 가상머신 추가
```sh
vim Vagrantfile

...
config.vm.box = "jasonc/centos7"

config.vm.define "admin01" do |admin01|
    admin01.vm.hostname = "admin01"
    admin01.vm.network "private_network", ip: "10.9.8.10"
end

config.vm.define "server01" do |server01|
    server01.vm.hostname = "server01"
    server01.vm.network "private_network", ip: "10.9.8.11"
end

config.vm.define "server02" do |server02|
    server02.vm.hostname = "server02"
    server02.vm.network "private_network", ip: "10.9.8.12"
end
...
```
- 이렇게 설정하면 vagrant 멀티 머신으로 작업을 실행할 때 명령을 실행하면 가상 컴퓨터 중 어느 가상 컴퓨터를 지정하지 않는 한 모든 시스템에 대해 해당 명령을 실행합니다.

따라서 Vagrant를 실행하면 이 세 가지 시스템을 모두 불러올 수 있습니다.
```sh
vagrant up

Bringing machine 'admin01' up with 'virtualbox' provider...
Bringing machine 'server01' up with 'virtualbox' provider...
Bringing machine 'server02' up with 'virtualbox' provider...
==> admin01: Importing base box 'jasonc/centos7'...
...
```

서버를 개별로 실행하고 싶다면 아래와 같이 불러 옵니다.
```sh
vagarnt up admin01
```

vagrant 상태 확인
```sh
vagrant status
Current machine states:

admin01                   running (virtualbox)
server01                  running (virtualbox)
server02                  running (virtualbox)
```

가상머신을 실행시킬때 에러가 발생한다면 Vagrantfile 에 입력이 잘못되었을 가능성이 크므로 잘못들어간 부분을 수정해야 합니다.

vagrant up 으로 가상머신을 실행한 후 ssh 를 사용하려면 구체적인 이름을 지정해야 합니다.
```sh
vagrant ssh admin01
```

호스트 파일에 두 서버를 추가하여 이름으로 대화할 수 있도록 하겠습니다.

호스트 파일을 살펴보면 파일 형식이 IP 주소와 이름, 그리고 해당 시스템에 액세스하려는 다른 추가 이름임을 알 수 있습니다.
```sh
[vagrant@admin01 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
127.0.1.1 admin01 admin01
```

이름을 지정한 다음 해당 시스템에 액세스하려는 다른 추가 이름을 지정할 수 있습니다.

`tee` 명령은 표준 입력에서 읽고 표준 출력 및 파일에 씁니다.

`tee` 는 수신하는 모든 것을 다른 방향으로 전달합니다.

덮어쓰기 대신 기존 파일에 추가할 수 있는 `-a` 옵션이 유용합니다.

```sh
[vagrant@admin01 ~]$ echo '10.9.8.11 server01' | sudo tee -a /etc/hosts
10.9.8.11 server01
[vagrant@admin01 ~]$ echo '10.9.8.12 server02' | sudo tee -a /etc/hosts
10.9.8.12 server02
[vagrant@admin01 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
127.0.1.1 admin01 admin01
10.9.8.11 server01
10.9.8.12 server02
```
- `/etc/hosts` 파일에 `ip` 주소와 이름을 추가 합니다.

이론상으로는 이러한 시스템과 이름으로 통신할 수 있으므로 `ping -c` 를 수행할 수 있습니다.
```sh
[vagrant@admin01 ~]$ ping -c 3 server01
PING server01 (10.9.8.11) 56(84) bytes of data.
64 bytes from server01 (10.9.8.11): icmp_seq=1 ttl=64 time=1.16 ms
64 bytes from server01 (10.9.8.11): icmp_seq=2 ttl=64 time=0.972 ms
64 bytes from server01 (10.9.8.11): icmp_seq=3 ttl=64 time=1.07 ms

--- server01 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 0.972/1.069/1.166/0.083 ms
[vagrant@admin01 ~]$ ping -c 1 server02
PING server02 (10.9.8.12) 56(84) bytes of data.
64 bytes from server02 (10.9.8.12): icmp_seq=1 ttl=64 time=0.794 ms

--- server02 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.794/0.794/0.794/0.000 ms
```

앞서 말했듯이 이 가상 머신을 메인 관리 서버로 사용할 예정이므로 여기에서 네트워크의 다른 가상 머신에서 실행되는 명령을 실행할 것입니다.

그래서 비밀번호 없이 다른 두 시스템에 접속하고 싶습니다. 이를 위해 가장 먼저 해야 할 일은 `SSH 키 쌍`을 만드는 것입니다.

## ssh key 생성
`ssh` 키 생성을 실행하여 키를 생성하고 여기서는 기본값을 그대로 사용하겠습니다.

```sh
[vagrant@admin01 ~]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/vagrant/.ssh/id_rsa.
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:GABPjx2w5p4FurATxn09ypXBpOUIPDGZhJ3I7sJw6W0 vagrant@admin01
The key's randomart image is:
+---[RSA 2048]----+
|. B*O..o         |
| + Xo*B.         |
|.  .Bo++         |
|o.++ ..oo        |
|*=.o..o=S        |
|o*.oEoo .        |
|+ ..oo           |
| .               |
|                 |
+----[SHA256]-----+
```
- ssh-keygen 으로 키쌍을 생성
- 비밀번호를 사용하지 않고 생성하면 매번 비밀번호를 입력할 필요 없이 ssh를 사용할 수 있습니다.

다음 단계는 원격 시스템에 공개 키를 입력하는 것이며, 이를 도와주는 편리한 명령이 있습니다. 
이를 SSH 복사 ID라고 합니다.

`server01` 에 id 를 ssh 로 복사합니다.
```sh
[vagrant@admin01 ~]$ ssh-copy-id server01
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"
The authenticity of host 'server01 (10.9.8.11)' can't be established.
ECDSA key fingerprint is SHA256:Fi4FisVgFyEkos9NgKz0q+zzZwe3+xhCHWGrXL+jZck.
ECDSA key fingerprint is MD5:b6:04:55:d7:db:3c:a8:a1:b6:f6:15:1f:be:7e:48:41.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
vagrant@server01's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'server01'"
and check to make sure that only the key(s) you wanted were added.
```
- server01 id 를 ssh 로 복사 합니다.
- 비밀번호를 설정하면 복사가 됩니다.
- server02 도 ssh 로 복사 합니다.

```sh
[vagrant@admin01 ~]$ ssh server01
[vagrant@server01 ~]$ ssh server02
```
- ssh 서버이름으로 서버를 변경 합니다.
- ssh 를 통해 다른 가상머신에 있습니다.

예를 들어 1번 서버에서 명령을 실행하고 싶으면 서버로 이 작업을 수행할 수 있습니다.

```sh
[vagrant@admin01 vagrant]$ ssh server01 hostname ; hostname
server01
admin01

[vagrant@admin01 vagrant]$ ssh server01 'hostname ; hostname'
server01
server01

[vagrant@admin01 vagrant]$ CMD1='hostname'; CMD2='uptime'
[vagrant@admin01 vagrant]$ ssh server01 "${CMD1} ; ${CMD2}"
server01
 22:44:23 up  1:00,  0 users,  load average: 0.01, 0.03, 0.05
```
- `hostname` 을 `;` 으로 구분하면 종료가 되기 때문에 원래 상태의 admin01 이 나옵니다.
- 한꺼번에 하려면 `''` 으로 감싸고 `;` 으로 구분해서 명령을 입력하면 하나의 서버에서 발생됩니다.
- 변수에 담아서 사용하는 경우에도 `""`으로 감싸서 사용합니다.

### ssh 프로세스 확인 및 에러
```sh
[vagrant@admin01 vagrant]$ ssh server01 'ps -ef | head -3'
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 21:44 ?        00:00:02 /usr/lib/systemd/systemd --switched-root --system --deserialize 21
root         2     0  0 21:44 ?        00:00:00 [kthreadd]

[vagrant@admin01 vagrant]$ ssh server01 ps -ef | head -3
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 21:44 ?        00:00:02 /usr/lib/systemd/systemd --switched-root --system --deserialize 21
root         2     0  0 21:44 ?        00:00:00 [kthreadd]

[vagrant@admin01 vagrant]$ ssh server03 uptime
ssh: Could not resolve hostname server03: Name or service not known

[vagrant@admin01 vagrant]$ echo $?
255
```
- '' 으로 감싸거나 감싸지 않아도 동일한 동작을 수행합니다.
- 종료 상태 `255`를 확인하여 `ssh` 오류와 방금 전달된 원격 명령에서 발생한 오류를 구분할 수 있습니다.
- 실제로 마지막으로 실행된 명령의 종료 상태와 일치하는 곳에서 `ssh`가 종료된다고 말하는 것이 더 정확합니다.

**Example**
항상 `true` 또는 종료 상태 `0`을 반환하는 `true`라는 명령이 있습니다.

```sh
[vagrant@admin01 vagrant]$ ssh server01 'false | true'
[vagrant@admin01 vagrant]$ echo $?
0
```

```sh
[vagrant@admin01 vagrant]$ ssh server01 'true | false'
[vagrant@admin01 vagrant]$ echo $?
1
```
- 종료 상태를 살펴보면 잘못된 명령이 종료 상태를 1로 반환했기 때문에 종료 상태가 1로 표시됩니다.


원격 시스템에서 파이프를 사용하는 경우 0이 아닌 모든 종료 상태가 반환되기를 원한다고 가정해 보겠습니다.

핑을 통해 서버에 연결할 수 있는지 여부를 확인하는 간단한 [스크립트](../multinet-demo01.sh)를 작성해 보겠습니다.

### 스크립트 실행
```sh
[vagrant@admin01 vagrant]$ ./multinet-demo01.sh 
Pinging server01
server01 up.
Pinging server02
server02 up.

[vagrant@admin01 vagrant]$ exit
logout
Connection to 127.0.0.1 closed.

vagrant halt server02

vagrant ssh admin01

[vagrant@admin01 ~]$ cd /vagrant/
[vagrant@admin01 vagrant]$ ./multinet-demo01.sh 
Pinging server01
server01 up.
Pinging server02
server02 down.
```
- `admin01`을 통해 모든 관리 작업을 수행할 관리 서버를 지정할 수 있습니다.
- 양방향도 설정할 수도 있지만, `단방향 관계`를 갖는 것이 일반적인 관행입니다.

### `sudo` 를 사용할때와 차이점
`ssh` 서버 하나의 `sudo` 아이디, `ssh` 명령은 현재 사용자로 실행되며, 이 경우 현재 사용자는 `vagrant`입니다.

그런 다음 vagrant 사용자로 1번 서버에 연결되고 방랑 사용자로 실행 중인 `sudo id` 명령을 실행하면 됩니다.

```sh
[vagrant@admin01 vagrant]$ ssh server01 sudo id
uid=0(root) gid=0(root) groups=0(root)
```
- 서버 하나의 가상 머신에서 `vagrant` 사용자로 `sudo id` 명령이 실행됩니다.
- `sudo`를 사용하면 루트 권한이 부여되므로 여기서 반환되는 아이디는 루트 아이디입니다.

이제 이 명령을 `sudo ssh server01 id`로 실행하면 로컬 시스템에서 루트 사용자로 `ssh`를 실행하고 로컬에서 의사 `ssh`를 실행하게 됩니다.
그런 다음 루트 사용자로 1번 서버에 연결한 다음 원격 시스템에서 가동 시간 명령을 실행합니다.

```sh
[vagrant@admin01 vagrant]$ sudo ssh server01 id
The authenticity of host 'server01 (10.9.8.11)' can't be established.
ECDSA key fingerprint is SHA256:Fi4FisVgFyEkos9NgKz0q+zzZwe3+xhCHWGrXL+jZck.
ECDSA key fingerprint is MD5:b6:04:55:d7:db:3c:a8:a1:b6:f6:15:1f:be:7e:48:41.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'server01,10.9.8.11' (ECDSA) to the list of known hosts.
root@server01's password: 
uid=0(root) gid=0(root) groups=0(root)
```
- 여기서 이 프로세스를 계속하려면 vagrant server01번의 루트 비밀번호를 입력해야 합니다.

`sudo ssh`를 실행한다는 것은 `server01`에 루트로 연결한다는 의미이며, 이를 위해서는 경로를 제공해야 합니다.

`sudo ssh`를 실행한다는 것은 `server01`에 루트로 연결한다는 의미이며, 이를 위해서는 `server01`의 루트 비밀번호를 제공해야 합니다.

## 정리
- 비밀번호 없이 작업을 수행하려면 루트 사용자에 대한 ssh 키를 생성하고 공개 키를 대상 서버에 복사해야 합니다.


### 참고
- [tee](/QuickReferences/SHELL_COMMAND.md#tee)
- [Script](../multinet-demo01.sh)