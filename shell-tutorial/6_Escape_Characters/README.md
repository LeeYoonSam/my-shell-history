# 6. Escape Characters

### 특정 문자는 쉘에 중요합니다. 
예를 들어 큰따옴표(") 문자를 사용하면 공백과 TAB 문자가 처리되는 방식에 영향을 주는 것을 보았습니다.
```shell
$ echo Hello       World
Hello World
$ echo "Hello       World"
Hello     World
```

그러면 Hello    "World" 를 어떻게 표시할까요?
```shell
$ echo "Hello   \"World\""
```
- 첫 번째와 마지막 " 문자는 두 단어 사이의 간격이 그대로 유지되도록 echo에 전달된 하나의 매개변수로 전체를 래핑합니다. 

하지만 코드는 다음과 같습니다.
```shell
$ echo "Hello   " World ""
```

다음 세 가지 매개변수로 해석됩니다.
1. "Hello   "
2. World
3. ""

출력
```shell
Hello    World
```

대부분의 문자(* , ' 등)는 큰따옴표("")로 묶어서 해석되지 않습니다(즉, 문자 그대로 사용됨). 

그것들은 있는 그대로 받아들여지고 호출되는 명령에 전달됩니다. 

별표(*)를 사용하는 예는 다음과 같습니다.

```shell
$ echo *
case.shtml escape.shtml first.shtml 
functions.shtml hints.shtml index.shtml 
ip-primer.txt raid1+0.txt
$ echo *txt
ip-primer.txt raid1+0.txt
$ echo "*"
*
$ echo "*txt"
*txt
```
- 첫 번째 예에서 *는 현재 디렉토리의 모든 파일을 의미하도록 확장됩니다.
- 두 번째 예에서 *txt는 txt로 끝나는 모든 파일을 의미합니다.
- 세 번째에서는 *를 큰따옴표로 묶어 문자 그대로 해석합니다.
- 네 번째 예에서도 동일하게 적용되지만 문자열에 txt를 추가했습니다.

그러나 ", $, ` 및 \는 큰따옴표로 묶인 경우에도 여전히 쉘에서 해석됩니다.

백슬래시(\) 문자는 이러한 특수 문자를 표시하는 데 사용되어 쉘에서 해석되지 않고 실행 중인 명령(예: echo)으로 전달됩니다.

따라서 문자열을 출력하려면: ($X의 값이 5라고 가정):

```shell
A quote is ", backslash is \, backtick is `.
A few spaces are    and dollar is $. $X is 5.
```

다음과 같이 작성해야 합니다.

```shell
$ echo "A quote is \", backslash is \\, backtick is \`."
A quote is ", backslash is \, backtick is `.
$ echo "A few spaces are    and dollar is \$. \$X is ${X}."
A few spaces are    and dollar is $. $X is 5.
```
- "가 공백을 유지하는 데 특별한 이유를 보았습니다.
- 달러($)는 변수를 표시하기 때문에 특별하므로 $X는 변수 X의 내용이 있는 쉘로 대체됩니다.
- 백슬래시(\)는 그 자체로 다른 문자를 표시하는 데 사용되기 때문에 특별합니다. 

완전한 쉘을 위해서는 다음 옵션이 필요합니다.
```shell
$ echo "This is \\ a backslash"
This is \ a backslash
$ echo "This is \" a quote and this is \\ a backslash"
This is " a quote and this is \ a backslash
```
- 따라서 백슬래시 자체는 문자 그대로 받아들여야 함을 나타내기 위해 이스케이프 처리되어야 합니다.
