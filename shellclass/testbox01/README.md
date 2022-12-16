# Vagrant Virtual Box 테스트

```sh
vagrant box add jasonc/centos7
```

폴더를 생성하고 vagrant 에 추가되어있는 박스를 올림
```sh
mkdir testbox01
cd testbox01

vagrant up
```
- 설정이 잘못되면 생성된 Vagrantfile 에서 config.vm.box 에 박스 이름이 맞는지 확인

Vagrant hostname 지정
```
#Vagrantfile

config.vm.box = ...
config.vm.hostname = "testbox01"
```
- 이 시점에서 `Vagrant Halt`를 실행한 다음 `Vagrant up`을 실행하여 이 변경 사항을 활성화할 수 있습니다.

`Vagrant`는 가상 머신을 다시 시작하는 바로 가기 `Vagrant Reload`를 제공하고 새로운 vagrant 구성을 만들고 가상 머신을 다시 시작합니다.
- Reload 후 vagrant ssh 로 진입하면 localhost -> 지정한 hostname 으로 변경되어 있습니다.

가상 머신에 10.9.8.7의 IP 주소를 부여해 보겠습니다.
```
#Vagrantfile

config.vm.network "private_network", ip: "10.9.8.7"
```
- vagrant reload

ping 확인
> ping 명령은 네트워크 연결을 테스트하는 간단한 방법 중 하나입니다.

```sh
ping -c 3 10.9.8.7
```
- 3개의 패킷을 보내기 위해 -c 3을 할 것이고 IP 주소인 10.9.8.7을 할 것입니다.
- 패킷 손실이 없었기 때문에 성공적으로 가상 머신을 핑할 수 있었습니다.
- ping 명령이 다시 실패하면 vagrant 파일의 내용을 다시 확인하고 수정 reload 로 계속 확인

마지막 단계는 호스트 운영 체제 또는 물리적 컴퓨터를 재부팅하는 것입니다.
- 가상 머신 사용을 완료했거나 가상 머신의 새 복사본으로 다시 시작하려는 경우 
    - run, vagrant, destroy

