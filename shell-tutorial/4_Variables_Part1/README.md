# Variables - Part I

> 존재하는 거의 모든 프로그래밍 언어에는 변수라는 개념이 있습니다.<br/>
> 즉, 값을 할당하고 해당 내용을 읽고 조작할 수 있는 메모리 덩어리의 상징적인 이름입니다.<br/>
> Bourne 쉘도 예외는 아니며 이 섹션에서는 그 아이디어를 소개합니다.
<br/>

"=" 기호 주위에 공백이 없어야 합니다. VAR=value 값이 동작, VAR = 값이 작동하지 않습니다.
- 첫 번째 경우 쉘은 "=" 기호를 보고 명령을 변수 할당으로 취급합니다. 
- 두 번째 경우, 쉘은 VAR이 명령의 이름이어야 한다고 가정하고 실행을 시도합니다.

**var.sh**
```shell
#!/bin/sh
MY_MESSAGE="Hello World"
echo $MY_MESSAGE
```
- 이렇게 하면 "Hello World" 문자열을 MY_MESSAGE 변수에 할당한 다음 변수 값을 출력합니다.
- Hello World 문자열 주위에 따옴표가 필요합니다.
- echo Hello World를 사용하지 않을 수 있지만 echo는 매개변수의 수에 제한이 없지만 변수는 하나의 값만 가질 수 있으므로 공백이 있는 문자열은 따옴표로 묶어야 쉘이 모든 매개변수를 하나로 취급할 수 있다는 것을 알 수 있습니다. 그렇지 않으면 쉘은 MY_MESSAGE=Hello를 할당한 후 World 명령을 실행하려고 시도합니다.
- 쉘은 변수 유형에 신경 쓰지 않습니다. 문자열, 정수, 실수 등 원하는 모든 것을 저장할 수 있습니다.
- 사실, 이것들은 모두 문자열로 저장되지만 숫자를 기대하는 루틴은 문자열로 취급할 수 있습니다.
- 변수에 문자열을 할당한 다음 1을 추가하려고 시도하면 해당 변수에서 벗어날 수 없습니다.

```shell
$ x="hello"
$ expr $x + 1
expr: non-numeric argument
$
```
- 이는 외부 프로그램 expr이 숫자만 예상하기 때문입니다. 그러나 다음 사이에는 구문상의 차이가 없습니다.

```shell
MY_MESSAGE="Hello World"
MY_SHORT_MESSAGE=hi
MY_NUMBER=1
MY_PI=3.142
MY_OTHER_PI="3.142"
MY_MIXED=123abc
```
- 쉘에 의한 해석을 피하기 위해 특수 문자는 적절하게 이스케이프해야 합니다.

read 명령을 사용하여 대화식으로 변수 이름을 설정할 수 있습니다. 다음 스크립트는 이름을 묻고 개인적으로 인사합니다.

**var2.sh**
```shell
#!/bin/sh
echo What is your name?
read MY_NAME
echo "Hello $MY_NAME - hope you're well."
```
- 이것은 표준 입력에서 제공된 변수로 행을 읽는 쉘 내장 명령 read를 사용하고 있습니다.
- 전체 이름을 지정하고 echo 명령 주위에 큰따옴표를 사용하지 않더라도 올바르게 출력됩니다. 이것은 어떻게 이루어지나요? 이전에 MY_MESSAGE 변수를 사용하여 설정하려면 큰따옴표를 넣어야 했습니다.
- 무슨 일이 일어 났는지 `read` 명령은 자동으로 입력 주위에 따옴표를 배치하여 공백이 올바르게 처리되도록합니다. (물론 출력을 인용해야 합니다 - 예를 들어 echo "$MY_MESSAGE").

## 변수의 범위

> Bourne 쉘의 변수는 C와 같은 언어에서처럼 선언할 필요가 없습니다. 그러나 선언되지 않은 변수를 읽으려고 하면 결과는 빈 문자열입니다. 경고나 오류가 발생하지 않습니다. 이로 인해 미묘한 버그가 발생할 수 있습니다.

MY_OBFUSCATED_VARIABLE=안녕하세요 그리고 echo $MY_OSFUCATED_VARIABLE 을 할당하면아무 것도 얻지 못할 것입니다(두 번째 OBFUSCATED의 철자가 틀리기 때문에).

변수의 범위에 근본적인 영향을 미치는 `export` 라는 명령이 있습니다. 변수에 무슨 일이 일어나고 있는지 정말로 알기 위해서는 이것이 어떻게 사용되는지 이해해야 합니다.


**myvar2.sh**

```shell
#!/bin/sh
echo "MYVAR is: $MYVAR"
MYVAR="hi there"
echo "MYVAR is: $MYVAR"
```

스크립트 실행
```shell
$ ./myvar2.sh
MYVAR is:
MYVAR is: hi there
```
- MYVAR는 값으로 설정되지 않았으므로 비어 있습니다. 그런 다음 값을 지정하면 예상한 결과가 나타납니다.

```shell
$ MYVAR=hello
$ ./myvar2.sh
MYVAR is:
MYVAR is: hi there
```
- 아직 설정되지 않았습니다.
- 대화형 셸에서 myvar2.sh를 호출하면 스크립트를 실행하기 위해 새 셸이 생성됩니다. 이것은 부분적으로 앞에서 논의한 스크립트 시작 부분의 #!/bin/sh 행 때문입니다.
- 쉘 스크립트를 포함하여 다른 프로그램에 상속되도록 변수를 내보내야 합니다.

```shell
$ export MYVAR
$ ./myvar2.sh
MYVAR is: hello
MYVAR is: hi there
```
- 이제 스크립트의 3행을 보십시오. 이것은 MYVAR의 값을 변경하고 있습니다. 그러나 이것이 대화형 쉘로 다시 전달될 방법은 없습니다. MYVAR 값을 읽어보십시오.

```shell
$ echo $MYVAR
hello
$
```
- 쉘 스크립트가 종료되면 환경이 파괴됩니다. 그러나 MYVAR는 대화형 쉘 내에서 hello의 값을 유지합니다.
- 스크립트에서 환경 변경 사항을 다시 수신하려면 스크립트를 소싱해야 합니다. 스크립트를 실행하기 위해 다른 셸을 생성하는 대신 자체 대화형 셸 내에서 스크립트를 효과적으로 실행합니다.
- `.` 를 통해 스크립트를 소싱할 수 있습니다. (점) 명령:

```shell
$ MYVAR=hello
$ echo $MYVAR
hello
$ . ./myvar2.sh
MYVAR is: hello
MYVAR is: hi there
$ echo $MYVAR
hi there
```
- 변경 사항이 이제 다시 쉘에 적용되었습니다! 예를 들어 .profile 또는 .bash_profile 파일이 작동하는 방식입니다.

쉘 스크립트로 범하기 쉬운 실수의 또 다른 예입니다. 이 시점에서 변수에 대해 언급할 가치가 있는 또 다른 사항은 다음 쉘 스크립트를 고려하는 것입니다.
```shell
#!/bin/sh
echo "What is your name?"
read USER_NAME
echo "Hello $USER_NAME"
echo "I will create you a file called $USER_NAME_file"
touch $USER_NAME_file
```
- 어떤 결과를 기대할 수 있는지 생각해 보십시오. 예를 들어 USER_NAME으로 "steve"를 입력하면 스크립트에서 steve_file을 생성해야 합니까?
- 아니요. USER_NAME_file이라는 변수가 없으면 오류가 발생합니다. 쉘은 변수가 끝나는 곳과 나머지가 시작되는 곳을 모릅니다. 이것을 어떻게 정의할 수 있습니까?
- 답은 변수 자체를 중괄호로 묶는 것입니다.

**user.sh**
```shell
#!/bin/sh
echo "What is your name?"
read USER_NAME
echo "Hello $USER_NAME"
echo "I will create you a file called ${USER_NAME}_file"
touch "${USER_NAME}_file"
```
- 쉘은 이제 우리가 변수 USER_NAME을 참조하고 있고 "_file" 접미사가 붙기를 원한다는 것을 알고 있습니다. 이것은 문제의 원인을 추적하기 어려울 수 있기 때문에 많은 새로운 쉘 스크립트 프로그래머의 몰락이 될 수 있습니다.
- 또한 "${USER_NAME}_file" 주위의 따옴표에 유의하십시오. 사용자가 "Steve Parker"(공백에 주의)를 입력한 경우 따옴표 없이
touch에 전달된 인수는 Steve와 Parker_file이 될 것입니다. 즉, 사실상 touch Steve Parker_file이라고 하는 것입니다. 이 파일은 하나가 아니라 두 개의 파일을 터치해야 합니다. 따옴표는 이것을 피합니다.

## 명령어

### read
> `read`는 표준 입력(파이프라인 입력 또는 키보드 입력)에서 한 줄의 내용씩 읽어 들이는 명령어 입니다.

**프롬프트 출력하기**
-p 옵션을 사용해 프롬프트를 출력할 수도 있습니다.

```shell
#!/bin/bash
# read_promt.sh

read -p "성은? > " last_name  
read -p "이름은? > " first_name  
echo "성은 ${last_name}이고, 이름은 ${first_name}입니다."  
```

결과
```shell
$ sh read_promt.sh
성은? >  Lee
이름은? > YoonSam
성은 Lee이고, 이름은 YoonSam입니다.
```

### 참고
- [쉘 스크립트(Shell Script) 기초(5) - read](https://jupiny.com/2017/07/10/shell-script-basic-5/)