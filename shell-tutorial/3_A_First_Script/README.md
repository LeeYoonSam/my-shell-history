# A First Script

## Hello World 출력하기

**first.sh**

```shell
#!/bin/sh
# This is a comment!
echo Hello World        # This is a comment, too!
```
- 첫 번째 줄은 파일이 `/bin/sh`에 의해 실행될 것임을 유닉스에 알려줍니다.<br/>
이것은 거의 모든 Unix 시스템에서 Bourne 셸의 표준 위치입니다.<br/>
`GNU/Linux`를 사용하는 경우 `/bin/sh`는 일반적으로 bash(또는 최근에는 dash)에 대한 `심볼릭 링크`입니다.
- 두 번째 줄은 특수 기호 #로 시작합니다. 이것은 라인을 주석으로 표시하고 쉘에서 완전히 무시됩니다.<br/>
유일한 예외는 파일의 맨 처음 줄이 #!으로 시작하는 경우입니다.<br/>
이것은 Unix가 특별히 취급하는 특별한 지시어입니다. 이는 `csh`, `ksh` 또는 다른 것을 대화식 쉘로 사용하더라도 `Bourne 쉘`에서 다음 내용을 해석해야 함을 의미합니다.<br/>
- 세 번째 줄은 다음 명령을 실행합니다. echo, 두 개의 매개변수 또는 인수 - 첫 번째는 "Hello"입니다. 두 번째는 "World"입니다. echo는 자동으로 매개변수 사이에 공백 하나를 넣습니다.<br/># 기호는 여전히 주석을 표시합니다. # 및 그 뒤에 오는 모든 것은 셸에서 무시됩니다.

### sh 파일 실행 시키기
- 이제 chmod 755 first.sh를 실행하여 텍스트 파일을 실행 가능하게 만들고 ./first.sh를 실행합니다.

**결과**
```shell
$ chmod 755 first.sh
$ ./first.sh
Hello World
$
```

```shell
$ echo Hello World
Hello World
```
- 먼저 echo는 매개변수 사이에 공백을 하나 넣습니다. "Hello"와 "World" 사이에 몇 개의 공백을 넣어도 기존과 동일하게 출력 됩니다.<br/>
두 개의 인수를 사용하여 echo 프로그램을 호출합니다. cp가 그들 사이의 간격에 대해 하는 것보다 더 신경 쓰지 않습니다.

**first1.sh 변경**
```shell
#!/bin/sh
# This is a comment!
echo "Hello      World"       # This is a comment, too!
```
- echo는 이제 하나의 인수("Hello    World" 문자열)로 호출되었습니다. 이것을 정확하게 출력합니다.
- 여기서 이해해야 할 점은 쉘이 호출되는 프로그램에 인수를 전달하기 전에 인수를 구문 분석한다는 것입니다. 이 경우 따옴표를 제거하지만 문자열을 하나의 인수로 전달합니다.


**first2.sh**
```shell
#!/bin/sh
# This is a comment!
echo "Hello      World"       # This is a comment, too!
echo "Hello World"
echo "Hello * World"
echo Hello * World
echo Hello      World
echo "Hello" World
echo Hello "     " World
echo "Hello "*" World"
echo `hello` world
echo 'hello' world
```
- 마지막 예제로 다음 스크립트를 입력합니다. 실행하기 전에 결과를 예측해 보십시오.