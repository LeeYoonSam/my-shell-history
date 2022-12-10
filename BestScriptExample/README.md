b# [30 Bash Script Examples](https://linuxhint.com/30_bash_script_examples/#t1)

# 첫 번째 BASH 프로그램 생성 및 실행:
> 터미널에서 또는 bash 파일을 실행하여 bash 스크립트를 실행할 수 있습니다.

터미널에서 다음 명령을 실행하여 매우 간단한 bash 문을 실행합니다. 명령의 출력은 'Hello World'입니다.

```sh
echo "Hello World"

# 출력
Hello World
```

두 가지 방법으로 bash 파일을 실행할 수 있습니다. 
- 하나는 bash 명령을 사용하는 것
- 다른 하나는 bash 파일에 실행 권한을 설정하고 파일을 실행하는 것입니다. 

여기에는 두 가지 방법이 모두 나와 있습니다.

```sh
$ bash First.sh
```

Or,

```sh
$ chmod a+x First.sh
$ ./First.sh
```