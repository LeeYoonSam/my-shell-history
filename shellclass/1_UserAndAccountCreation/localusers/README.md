# Local Users

## 시작시 공통으로 해야하는 작업
- 가상머신을 시작하고 연결
```shell
cd shellclass
cd localusers
vagrnat up
```
- 폴더 이동 후 가상머신 시작 및 연결

```shell
vagrant ssh
```
- ssh 접속

```shell
cd /vagrant
```
- 이제 가상 머신 내부에 있으므로 Slash Vagrant의 공유 디렉토리에 시드할 것입니다.


## Shell Script 표현식
Shell Script 표현식 | 부르는 이름
--- | ---
\# | Sharp
! | Bang
#! | shebang (shebang이라고 불리는 이유는 파운드 기호가 때때로 샤프라고 불리기 때문입니다.)


## 내장함수
| 명령어 | 설명 |
| --- | --- |
| type -a command | 시스템에서 Echo의 모든 인스턴스를 보려면 모두 A를 입력한 다음 echo를 입력합니다. |
| echo "some text" | 출력 |
| help echo \|less  | echo 에 대한 설명을 줄여서 보여줌 |

## Variables
```sh
WORD='script'

echo "WORD" # -> script
echo 'WORD' # -> $WORD
```
- 구체적이고 아무 것도 변경되지 않도록 하려면 작은따옴표를 사용하십시오.

<br/>
<br/>

# 13. Special Variables, Pseudocode, Command Substitution, if Statement, Conditionals.

**배울내용**
- 쉘이 생성하는 몇 가지 특수 변수
- 변수에 있는 명령의 출력
- if 문


### Root User or not

**General**
```
./luser_demo02.sh
```

**Root**
```
sudo ./luser_demo02.sh
```

## Linux Shell Scripting: A Project-Based Approach to Learning
- `if` 문과 함께 사용하는 이 이중 괄호 구문은 `bash` 전용

<br/>
<br/>

# 14. Exit Statuses, Return Codes, String Test Conditionals, More Special Variables.

**배울 내용**
- if 표현식에서 참이 아니면 무언가를 하라는 논리를 사용
- 종료 명령의 상태를 확인하여 주어진 명령이 실패했는지 또는 성공했는지 확인하는 방법
- 스크립트의 종료 상태를 제어하는 ​​방법

<br/>
<br/>

# 15. Reading Standard Input, Creating Accounts, Username Conventions, More Quoting.

**배울 내용**
- 스크립트를 실행하는 사람으로부터 입력을 받는 방법
- Linux 시스템에서 계정을 만드는 방법

## 참고
- [luser-demo04.sh](./luser-demo04.sh)


# 18. Random Data, Cryptographic Hash Functions, Text and String Manipulation.
> 랜덤 데이터, 암호화 해시 함수, 텍스트 및 문자열 조작.

**배울 내용**
- 임의의 데이터를 생성하는 몇 가지 다른 방법
- 임의 암호 생성 프로세스를 자동화하는 방법
    - 사용자의 입력을 덜 요구하여 스크립트를 개선

## 참고
- [luser-demo05.sh](./luser-demo05.sh)