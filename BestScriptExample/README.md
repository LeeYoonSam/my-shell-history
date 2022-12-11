# [30 Bash Script Examples](https://linuxhint.com/30_bash_script_examples/#t1)

- [첫 번째 BASH 프로그램 생성 및 실행](#첫-번째-bash-프로그램-생성-및-실행)
- [echo 명령 사용](#echo-명령-사용)

---

# 첫 번째 BASH 프로그램 생성 및 실행
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

# echo 명령 사용
다양한 옵션과 함께 echo 명령을 사용할 수 있습니다. 몇 가지 유용한 옵션이 다음 예제에 언급되어 있습니다. 옵션 없이 `echo` 명령을 사용하면 기본적으로 새 줄이 추가됩니다. `-n` 옵션은 새 줄 없이 텍스트를 인쇄하는 데 사용되며 `-e` 옵션은 출력에서 ​​백슬래시 문자를 제거하는 데 사용됩니다. 이름이 `echo_example.sh`인 새 bash 파일을 만들고 다음 스크립트를 추가합니다.
