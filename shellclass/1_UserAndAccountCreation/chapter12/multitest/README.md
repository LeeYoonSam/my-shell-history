# Multitest

1. vagrant 파일을 생성하는 vagrant 프로젝트를 초기화하는 것입니다.
```sh
vagrant init jasonc/centos7
```

2. 두 개의 가상 머신을 정의합니다.
```
# Vagrantfile

  config.vm.define "test1" do |test1|
    test1.vm.hostname = "test1"
    test1.vm.network "private_network", ip: "10.9.8.5"
  end

  config.vm.define "test2" do |test2|
    test2.vm.hostname = "test2"
    test2.vm.network "private_network", ip: "10.9.8.6"
  end
```

3. 각각의 머신을 ssh 로 실행
```sh
vagrant ssh test1
vagrant ssh test2
```
- vagrant destroy 를 하면 다 삭제되므로 유의

4. ping 확인
> ping 명령은 네트워크 연결을 테스트하는 간단한 방법 중 하나입니다.

```sh
ping -c 3 10.9.8.5
ping -c 3 10.9.8.6
```

5. 사용하지 않는다면 머신 중지
```sh
vagrant halt
```

## 참고
- Vagrant 프로젝트 디렉토리는 슬래시 vagrant 디렉토리를 통해 마운트되거나 공유됩니다.
- 로컬 디렉토리에 있는 유일한 파일은 vagrant 파일이며 다음 내에서 해당 파일을 볼 수 있습니다.

