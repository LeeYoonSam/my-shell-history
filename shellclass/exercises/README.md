# Exercises Help

## run-everywhere.sh
스크립트 실행 예시
```bash
sudo ./run-everywhere.sh -nsv hostname
```

필요한 추가 작업
- 서버 추가
- `tee` 커맨드를 사용해서 `/etc/hosts` 에 서버 등록
- 네트워크의 다른 가상 머신에서 명령을 실행 하기 위해 암호 없이 사용 가능한 ssh 키쌍 추가

### Vagrantfile 서버 추가
이 셸 스크립트를 실행하려면 `Vagrantfile` 에 서버를 추가해야 합니다.

```bash
Vagrant.configure("2") do |config|
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
- 설정을 변경하고 나면 `vagrant up` 으로 서버를 기동합니다.

### vagrant ssh 실행
```bash
vagrant ssh admin01
```
- 다른 서버가 실행중인지 확인하려면 ping 을 사용합니다.
```bash
ping -c 3 10.9.8.11
```

### tee 를 사용해서 /etc/hosts 에 server 를 추가
```bash
echo '10.9.8.11 server01' | sudo tee -a /etc/hosts
echo '10.9.8.12 server02' | sudo tee -a /etc/hosts
```

**/etc/hosts 확인**
```bash
cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
127.0.1.1 admin01 admin01
10.9.8.11 server01
10.9.8.12 server02
```

**추가한 서버 이름으로 ping 확인**
```bash
ping -c 3 server01
PING server01 (10.9.8.11) 56(84) bytes of data.
64 bytes from server01 (10.9.8.11): icmp_seq=1 ttl=64 time=0.830 ms
64 bytes from server01 (10.9.8.11): icmp_seq=2 ttl=64 time=0.875 ms
64 bytes from server01 (10.9.8.11): icmp_seq=3 ttl=64 time=0.975 ms
```

### SSH Key 쌍 추가
네트워크의 다른 가상 머신에서 실행할 명령을 여기에서 실행하십시오.
암호 없이 다른 두 시스템에 ssh로 접속하고 싶습니다.

가장 먼저 해야 할 일은 SSH 키 쌍을 만드는 것입니다.

**ssh-keygen 으로 키쌍 생성**
```bash
ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/vagrant/.ssh/id_rsa.
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:OFfSW4ATT0j9BtQzvmlKzSA8xNOXMi07RT6hc+m37fY vagrant@admin01
The key's randomart image is:
+---[RSA 2048]----+
|       ooB++o.   |
|        B+B+Oo   |
|       o.o*@*o   |
|       .+o+*+.   |
|      o So.*.o.  |
|       o  . *. o |
|         . o  . .|
|          .    ..|
|               .E|
+----[SHA256]-----+
```
- 원할때 암호를 묻지 않고 사용하기 위해 `passphrase` 를 사용하지 않습니다.

다음 단계는 공개 키를 원격 시스템에 저장하는 것입니다.
**ssh id 복사**
```bash
ssh-copy-id server01
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
- vagrant@server01's password: 는 `vagrant` 입니다.
- 같은 방식으로 server02 도 추가해줍니다.

**ssh 로 server에 접속되는지 확인**
```bash
[vagrant@admin01 ~]$ ssh server01
[vagrant@server01 ~]$ 

[vagrant@admin01 ~]$ for N in 1 2 
> do
>   ssh server0${N} hostname
> done
server01
server02
```