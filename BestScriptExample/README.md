# [30 Bash Script Examples](https://linuxhint.com/30_bash_script_examples/#t1)

- [첫 번째 BASH 프로그램 생성 및 실행](#첫-번째-bash-프로그램-생성-및-실행)
- [echo 명령](#echo-명령-사용)
- [주석](#주석-사용)
- [여러 줄 주석](#여러-줄-주석-사용)
- [While Loop](#while-루프-사용)
- [For Loop](#for-loop-사용)
- [Get User Input(사용자 입력 받기)](#get-user-input사용자-입력-받기)

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

```sh
#!/bin/bash
echo "Printing text with newline"
echo -n "Printing text without newline"
echo -e "\nRemoving \t backslash \t characters\n"
```

# 주석 사용
> `#` 기호는 `bash` 스크립트에서 한 줄 주석을 추가하는 데 사용됩니다.

`comment_example.sh`라는 새 파일을 만들고 한 줄 주석으로 다음 스크립트를 추가합니다.

```sh
#!/bin/bash

# Add two numeric value
((sum=25+35))

#Print the result
echo $sum
```

# 여러 줄 주석 사용
`bash`에서 여러 줄 주석을 다양한 방법으로 사용할 수 있습니다.

간단한 방법은 다음 예제에 나와 있습니다. 

`multiline-comment.sh`라는 새 bash를 만들고 다음 스크립트를 추가합니다. 

여기서 `:` 및 ` ' ` 기호는 bash 스크립트에서 여러 줄 주석을 추가하는 데 사용됩니다. 

다음 스크립트는 5의 제곱을 계산합니다.

```sh
#!/bin/bash
: '
The following script calculates
the square value of the number, 5.
'
((area=5*5))
echo $area
```

# While 루프 사용
`while` 루프의 사용법을 알기 위해 `while_example.sh`라는 이름의 `bash` 파일을 만듭니다. 

예제에서 `while` 루프는 5번 반복됩니다. 카운트 변수의 값은 각 단계에서 1씩 증가합니다. `count` 변수의 값이 5가 되면 `while` 루프가 종료됩니다.

```sh
#!/bin/bash
valid=true
```

### 참고
- [while loop example](./while-loop)

# For Loop 사용
`for_example.sh` 스크립트 파일 생성
아래 예제의 for loop는 10번 반복하고 변수 counter의 모든 값을 한 줄에 인쇄합니다.
```sh
#!/bin/bash
for (( counter=10; counter>0; counter-- ))
do
    echo -n "$counter "
done
printf "\n"
```

출력
```sh
./for_example.sh
> 10 9 8 7 6 5 4 3 2 1
```

### 참고
- [for loop example](./for-loop)
- [다양한 for loop 사용법](https://linuxhint.com/bash-for-loop-examples/)


# Get User Input(사용자 입력 받기)
`read` 명령은 bash에서 사용자로부터 입력을 받는 데 사용됩니다.

하나의 문자열 값을 사용자로부터 가져와 다른 문자열 값을 조합하여 표시합니다.

```sh
#!/bin/bash
echo "Enter Your Name"
read name
echo "Welcome $name to LinuxHint"
```

### 참고
- [Bash Script User Input](https://linuxhint.com/bash-script-user-input/)
- [sample](./user-input)


# Using if statement (if 문 사용)
단일 또는 여러 조건과 함께 `if` 조건을 사용할 수 있습니다.

`if` 문의 시작 블록과 끝 블록은 `if`와 `fi`로 정의됩니다.

bash에서 use if 문을 알기 위해 다음 스크립트로 `simple_if.sh`라는 파일을 만듭니다.

여기서 10은 변수 n에 할당되고 `$n`의 값이 10보다 작으면 **한 자리 숫자입니다**가 출력되고, 그렇지 않으면 **두 자리 숫자입니다**가 출력됩니다.<br/>
비교를 위해 여기서는 `-lt`를 사용합니다.<br/>
다른 비교 키워드는 `-eq`는 같음, `-ne`은 같지 않음, `-gt`는 bash 스크립트보다 큼을 의미합니다.

```sh
#!/bin/bash
n=10
if [ $n -lt 10 ]
then
    echo "It is a one digit number"
else
    echo "It is a two digit number"
fi
```

### 참고
- [Using if statement](https://linuxhint.com/30_bash_script_examples/#t8)
- [sample](./if-statement/simple_if.sh)


# Using if statement with AND logic(AND 논리와 함께 if 문 사용)

두 개 이상의 조건이 있는 `if` 문에서 서로 다른 유형의 논리 조건을 사용할 수 있습니다. 

`AND` 논리를 사용하여 `if` 문에서 여러 조건을 정의하는 방법은 다음 예에 나와 있습니다. `&&`는 `if` 문의 `AND` 논리를 적용하는 데 사용됩니다. 

다음 코드를 확인하기 위해 `if_with_AND.sh`라는 파일을 생성합니다. 

여기에서 사용자 이름 및 비밀번호 변수의 값은 사용자로부터 가져와 `admin` 및 `secret`과 비교됩니다. 두 값이 모두 일치하면 **유효한 사용자**가 출력되고 그렇지 않으면 **잘못된 사용자**가 출력됩니다.

### 참고
- [Using if statement with AND logic](https://linuxhint.com/30_bash_script_examples/#t9)
- [sample](./if-statement/if_with_AND.sh)


# Using if statement with OR logic (OR 논리와 함께 if 문 사용)
`||`는 `if` 조건에서 `OR` 논리를 정의하는 데 사용됩니다.<br/>
`if` 문의 `OR` 논리 사용을 확인하기 위해 다음 코드로 `if_with_OR.sh`라는 파일을 생성합니다.<br/>
여기서 n의 값은 사용자로부터 가져옵니다. 값이 15 또는 45이면 출력은 **You win the game**이고, 그렇지 않으면 출력은 **You lost the game**입니다.

```sh
#!/bin/bash

echo 'Enter any number'
read n

if [[ $n -eq 15 || $n -eq 45 ]]
then
    echo 'You won the game'
else
    echo 'You loas the game'
fi
```

### 참고
- [Using if statement with OR logic](https://linuxhint.com/30_bash_script_examples/#t10)
- [Sample](./if-statement/if_with_OR.sh)