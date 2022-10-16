# 8. Test
> 테스트는 작성된 거의 모든 쉘 스크립트에서 사용됩니다.<br/>
> test 는 자주 직접 호출되지 않기 때문에 그렇게 보이지 않을 수도 있습니다.<br/>
> `[` 는 쉘 프로그램을 더 읽기 쉽게 만들기 위한 테스트용 심볼릭 링크입니다.<br/>
> 또한 일반적으로 쉘 내장입니다(즉, Unix 환경이 다르게 설정되더라도 쉘 자체가 `[` 테스트를 의미하는 것으로 해석함을 의미합니다)

```shell
$ type [
[ is a shell builtin
$ which [
/usr/bin/[
$ ls -l /usr/bin/[
lrwxrwxrwx 1 root root 4 Mar 27 2000 /usr/bin/[ -> test
$ ls -l /usr/bin/test
-rwxr-xr-x 1 root root 35368 Mar 27  2000 /usr/bin/test
```
- 이것은 `[`가 ls 및 다른 프로그램과 마찬가지로 실제로 프로그램이므로 공백으로 둘러싸여야 함을 의미합니다.

```shell
if [$foo = "bar" ]
```
- 위 코드는 작동 안 할 것이다. 이는 `if test$foo = "bar" ]`인 것처럼 해석되며, 이는 '['로 시작하지 않는 ']'입니다. 모든 연산자 주위에 공백을 넣으십시오.
- 모든 연산자 주위에 공백을 넣으십시오. 필수 공백을 'SPACE'라는 단어로 강조 표시했습니다. 'SPACE'를 실제 공백으로 바꿉니다. 거기에 공간이 없으면 작동하지 않습니다.

```shell
if SPACE [ SPACE "$foo" SPACE = SPACE "bar" SPACE ]
```
- 참고: 일부 쉘은 문자열 비교를 위해 "=="도 허용합니다. 이것은 이식할 수 없습니다. 문자열에는 단일 "="를 사용하고 정수에는 "-eq"를 사용해야 합니다.
- 테스트는 간단하지만 강력한 비교 유틸리티입니다. 자세한 내용을 보려면 시스템에서 man test를 실행하십시오. 다음은 몇 가지 사용법과 일반적인 예입니다.

테스트는 if 및 while 문을 통해 가장 자주 간접적으로 호출됩니다. 테스트라는 프로그램을 만들고 실행하려고 하면 프로그램 대신 이 쉘 내장이 호출되기 때문에 어려움에 처하게 되는 이유이기도 합니다!

if...then...else...의 구문은 다음과 같습니다.
```shell
if [ ... ]
then
  # if-code
else
  # else-code
fi
```
- fi는 거꾸로 된 경우입니다! 이것은 나중에 case 및 esac와 함께 다시 사용됩니다.

또한 구문에 유의하십시오. `if [ ... ]` 및 `then` 명령은 서로 다른 행에 있어야 하지만 세미콜론 `;` 으로 분리할 수 있습니다

```shell
if [ ... ]; then
  # do something
fi
```

다음과 같이 elif를 사용할 수도 있습니다.

```shell
if  [ something ]; then
 echo "Something"
 elif [ something_else ]; then
   echo "Something else"
 else
   echo "None of the above"
fi
```
- 이것은 [ something ] 테스트가 성공하면 `Something`을 출력하고, 그렇지 않으면 [ something_else ]를 테스트하고, 성공하면 `Something other`를 출력합니다. 다른 모든 방법이 실패하면 `None of the above`이 표시됩니다.

다음 코드 조각을 시도하고 실행하기 전에 변수 X를 다양한 값으로 설정합니다.(-1, 0, 1, hello, bye 등 시도)

```shell
$ X=5
$ export X
$ ./test.sh
  ... output of test.sh ...
$ X=hello
$ ./test.sh
  ... output of test.sh ...
$ X=test.sh
$ ./test.sh
  ... output of test.sh ...
```
- 그런 다음 /etc/hosts와 같은 기존 파일의 이름으로 $X를 사용하여 다시 시도하십시오.

**test.sh**
```shell
#!/bin/sh
if [ "$X" -lt "0" ]
then
  echo "X is less than zero"
fi
if [ "$X" -gt "0" ]; then
  echo "X is more than zero"
fi
[ "$X" -le "0" ] && \
      echo "X is less than or equal to  zero"
[ "$X" -ge "0" ] && \
      echo "X is more than or equal to zero"
[ "$X" = "0" ] && \
      echo "X is the string or number \"0\""
[ "$X" = "hello" ] && \
      echo "X matches the string \"hello\""
[ "$X" != "hello" ] && \
      echo "X is not the string \"hello\""
[ -n "$X" ] && \
      echo "X is of nonzero length"
[ -f "$X" ] && \
      echo "X is the path of a real file" || \
      echo "No such file: $X"
[ -x "$X" ] && \
      echo "X is the path of an executable file"
[ "$X" -nt "/etc/passwd" ] && \
      echo "X is a file which is newer than /etc/passwd"
```
- 세미콜론(;)을 사용하여 두 줄을 연결할 수 있습니다. 이것은 종종 간단한 if 문에서 약간의 공간을 절약하기 위해 수행됩니다.
- 백슬래시(\\)는 유사하지만 반대 목적을 수행합니다. 이는 쉘에 이것이 라인의 끝이 아니라 다음 라인이 현재 라인의 일부로 처리되어야 함을 알려줍니다.
- 백슬래시(\\) 또는 세미콜론(;) 뒤에 다음 줄을 들여쓰는 것이 일반적입니다.

예를 들어, 세미콜론(;)은 종종 다음과 같이 if 및 then 키워드를 결합하는 데 사용됩니다.
```shell
if [ "$X" -nt "/etc/passwd" ]; then
      echo "X is a file which is newer than /etc/passwd"
fi
```
- 백슬래시(\\)는 가독성을 위해 쉘 스크립트 파일의 두 줄에 걸쳐 한 줄 명령을 분할하는 데 사용됩니다.

```shell
[ "$X" -nt "/etc/passwd" ] && \
      echo "X is a file which is newer than /etc/passwd"
```
- 이 예제에서 볼 수 있듯이 test는 숫자, 문자열 및 파일 이름에 대해 많은 테스트를 수행할 수 있습니다.
- -a, -e(둘 다 "파일이 존재함"을 의미), -S(파일이 소켓임), -nt(파일이 다음보다 최신임), -ot(파일이 다음보다 이전임), -ef를 지적해 준 Aaron에게 감사드립니다. (경로는 동일한 파일을 참조함) 및 -O(파일은 테스트를 실행하는 사용자가 소유함)는 기존 Bourne 셸에서 사용할 수 없습니다(예: Solaris, AIX, HPUX 등의 /bin/sh).

if 문을 작성하는 더 간단한 방법이 있습니다: && 및 || 명령은 결과가 각각 true 또는 false인 경우 실행할 코드를 제공합니다.

```shell
#!/bin/sh
[ $X -ne 0 ] && echo "X isn't zero" || echo "X is zero"
[ -f $X ] && echo "X is a file" || echo "X is not a file"
[ -n $X ] && echo "X is of non-zero length" || \
      echo "X is of zero length"
```
- 이 구문은 테스트에 링크된 [ 라는 파일(또는 셸 내장)이 있기 때문에 가능합니다. 그러나 과도하게 사용하면 코드를 읽기가 매우 어려울 수 있으므로 이 구문을 사용하는 데 주의하십시오. if...then...else... 구조가 훨씬 읽기 쉽습니다. [...] 구문을 사용하는 것은 독자의 주의를 산만하게 하고 싶지 않은 while 루프 및 사소한 온전성 검사에 권장됩니다.

X를 숫자가 아닌 값으로 설정하면 처음 몇 번 비교하면 다음과 같은 메시지가 나타납니다.
```shell
test.sh: [: integer expression expected before -lt
test.sh: [: integer expression expected before -gt
test.sh: [: integer expression expected before -le
test.sh: [: integer expression expected before -ge
```
- 이는 -lt, -gt, -le 및 -ge 비교가 정수용으로만 설계되었으며 문자열에서는 작동하지 않기 때문입니다. !=와 같은 문자열 비교는 "5"를 문자열로 기쁘게 처리하지만 "Hello"를 정수로 취급하는 합리적인 방법이 없으므로 정수 비교가 불평합니다.

셸 스크립트가 보다 원활하게 작동하도록 하려면 테스트하기 전에 변수의 내용을 확인해야 합니다. 아마도 다음과 같을 것입니다.

```shell
echo -en "Please guess the magic number: "
read X
echo $X | grep "[^0-9]" > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
  # If the grep found something other than 0-9
  # then it's not an integer.
  echo "Sorry, wanted a number"
else
  # The grep found only 0-9, so it's an integer. 
  # We can safely do a test on it.
  if [ "$X" -eq "7" ]; then
    echo "You entered the magic number!"
  fi
fi
```
- 이러한 방식으로 사용자에게 보다 의미 있는 메시지를 표시하고 정상적으로 종료할 수 있습니다. 
- $? 변수는 변수 - 파트 II에 설명되어 있으며 grep은 복잡한 짐승이므로 다음과 같이 진행합니다. 
- grep [0-9]는 숫자(0-9) 및 기타 문자를 포함하는 텍스트 행을 찾습니다. 따라서 캐럿(^) grep [^0-9]는 숫자로만 구성되지 않은 행만 찾습니다. 그러면 우리는 반대를 취할 수 있습니다(성공이 아니라 실패에 대해 행동함으로써). `>/dev/null 2>&1`은 출력이나 오류를 사용자 화면으로 이동하는 대신 특수 "null" 장치로 보냅니다
- 이 페이지는 grep -v [0-9]가 작동한다고 주장했지만 이것은 분명히 너무 단순합니다.

다음과 같이 while 루프에서 테스트를 사용할 수 있습니다.

**test2.sh**
```shell
#!/bin/sh
X=0
while [ -n "$X" ]
do
  echo "Enter some text (RETURN to quit)"
  read X
  echo "You said: $X"
done
```
- 이 코드는 RETURN을 누를 때까지 계속 입력을 요청합니다(X는 길이가 0임). 
- [ -n "$X" ] 동안 $X 주위의 따옴표를 놓쳤습니다. 이러한 따옴표가 없으면 $X가 비어 있을 때 테스트할 것이 없습니다.

```shell
$ ./test2.sh
Enter some text (RETURN to quit)
fred
You said: fred
Enter some text (RETURN to quit)
wilma
You said: wilma
Enter some text (RETURN to quit)

You said:
$ 
```
이것은 루프 내에서 다른 테스트로 정리할 수 있습니다.

```shell
#!/bin/sh
X=0
while [ -n "$X" ]
do
  echo "Enter some text (RETURN to quit)"
  read X
  if [ -n "$X" ]; then
    echo "You said: $X"
  fi
done
```

이 페이지의 if 문에 대해 두 가지 다른 구문을 사용했습니다.

```shell
if [ "$X" -lt "0" ]
then
  echo "X is less than zero"
fi

..........  and  ........

if [ -n "$X" ]; then
  echo "You said: $X"
fi
```
- if 문과 then 구문 사이에는 휴식 시간이 있어야 합니다. 이것은 세미콜론이나 개행일 수 있으며 어느 것이든 상관없지만 if와 then 사이에는 둘 중 하나가 있어야 합니다.

```shell
if [ -n "$X" ]
  echo "You said: $X"
```
- 그러나 then과 fi는 절대적으로 필요합니다.