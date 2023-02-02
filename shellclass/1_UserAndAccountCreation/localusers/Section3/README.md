# Section 3: User and Account Creation

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
- [Script](./luser-demo04.sh)