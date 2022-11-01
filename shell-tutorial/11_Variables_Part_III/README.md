# 11. Variables - Part III

> Variables Part1 에서 언급했듯이 변수 주위의 중괄호는 혼동을 방지합니다.

```shell
foo=sun
echo $fooshine     # $fooshine is undefined
echo ${foo}shine   # displays the word "sunshine"
```
- 하지만 그게 다가 아닙니다. 이 멋진 브래킷에는 훨씬 더 강력한 또 다른 용도가 있습니다. 
- 변수가 정의되지 않았거나 null이 되는 문제를 처리할 수 있습니다(쉘에서는 undefined와 null 사이에 큰 차이가 없습니다).

### 기본값 사용
사용자에게 입력을 요청하지만 기본값은 허용하는 다음 코드 스니펫을 고려하십시오.

```shell
#!/bin/sh
echo "What is your name [ `whoami` ] \c"
read myname
if [ -z "$myname" ]; then
  myname=`whoami`
fi
echo "Your name is : $myname"
```
- echo에 "\c"을 전달하면 줄 바꿈을 추가하지 않습니다(bash 및 csh의 경우). Dash, Bourne 및 기타 호환 셸의 경우 줄 끝에 "\c"를 대신 사용합니다.
- Ksh는 두 가지 형태를 모두 이해합니다. (참고: 다양한 구현, 특히 Dash/Bourne 대 Bash에 대한 참고 사항은 /echo.html 참조)

이 스크립트는 "RETURN"을 눌러 기본값을 수락하면 다음과 같이 실행됩니다.
```shell
steve$ ./name.sh
What is your name [ steve ]
Your name is : steve
```

사용자 입력
```shell
steve$ ./name.sh
What is your name [ steve ] foo
Your name is : foo
```
- 이것은 쉘 변수 기능을 사용하여 더 잘 수행할 수 있습니다. 

중괄호와 특수 ":-" 사용법을 사용하여 변수가 설정되지 않은 경우 사용할 기본값을 지정할 수 있습니다.
```shell
echo -en "What is your name [ `whoami` ] "
read myname
echo "Your name is : ${myname:-`whoami`}"
```
- 이것은 특별한 경우로 간주될 수 있습니다. 우리는 로그인 이름(UID)을 인쇄하는 whoami 명령의 출력을 사용하고 있습니다.

정식적인 예는 다음과 같이 고정 텍스트를 사용하는 것입니다.
```shell
echo "Your name is : ${myname:-John Doe}"
```
- 백틱의 다른 사용과 마찬가지로 \`whoami\`는 서브셸에서 실행되므로 백틱 내에서 cd ​​명령이나 다른 변수 설정은 현재 실행 중인 쉘에 영향을 미치지 않습니다.

### 기본값 사용 및 설정

정의되지 않은 경우 변수를 기본값으로 설정하는 또 다른 구문 ":="이 있습니다.

```shell
echo "Your name is : ${myname:=John Doe}"
```
- 이 기술은 $myname 변수에 대한 모든 후속 액세스가 항상 사용자가 입력한 값을 얻거나 그렇지 않은 경우 "John Doe"를 얻는다는 것을 의미합니다.
