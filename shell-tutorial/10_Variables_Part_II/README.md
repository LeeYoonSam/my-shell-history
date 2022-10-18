# 10. Variables - Part II

> 이미 설정되어 있는 변수 집합이 있으며 대부분은 값을 할당할 수 없습니다.<br/>
> 여기에는 스크립트가 실행 중인 환경에 대해 알기 위해 사용할 수 있는 유용한 정보가 포함될 수 있습니다.

- 첫 번째 변수 집합은 `$0 .. $9` 및 `$#`입니다.
- `$0` 변수는 호출된 프로그램의 기본 이름입니다.
- `$1 .. $9`는 스크립트가 호출된 처음 9개의 추가 매개변수입니다.
- `$@` 변수는 모든 매개변수 `$1` .. 무엇이든 상관없습니다. 변수 `$*`는 유사하지만 공백과 인용 부호를 보존하지 않으므로 `File with spaces`은 `File` `with` `space`이 됩니다. 이것은 A First Script에서 보았던 echo 항목과 유사합니다. 일반적으로 `$@`를 사용하고 `$*`를 피하십시오.
- `$#`는 스크립트가 호출된 매개변수의 수입니다.

**var3.sh**
```shell
#!/bin/sh
echo "I was called with $# parameters"
echo "My name is $0"
echo "My first parameter is $1"
echo "My second parameter is $2"
echo "All parameters are $@"
```

출력 결과
```shell
$ /home/steve/var3.sh
I was called with 0 parameters
My name is /home/steve/var3.sh
My first parameter is
My second parameter is    
All parameters are 
$
$ ./var3.sh hello world earth
I was called with 3 parameters
My name is ./var3.sh
My first parameter is hello
My second parameter is world
All parameters are hello world earth
```
- `$0`의 값은 스크립트가 호출된 방식에 따라 변경됩니다. 외부 유틸리티 기본 이름은 이를 정리하는 데 도움이 될 수 있습니다.

```shell
echo "My name is `basename $0`"
```
- `$#` 및 `$1` .. `$9`는 쉘에 의해 자동으로 설정됩니다.
- shift 명령을 사용하여 9개 이상의 매개변수를 사용할 수 있습니다.

**var4.sh**
```shell
#!/bin/sh
while [ "$#" -gt "0" ]
do
  echo "\$1 is $1"
  shift
done  
```
- 이 스크립트는 `$#`이 0이 될 때까지 `shift`를 계속 사용합니다. 이 지점에서 목록이 비어 있습니다.

또 다른 특수 변수는 `$?`입니다. 여기에는 마지막 실행 명령의 종료 값이 포함됩니다.

```shell
#!/bin/sh
/usr/local/bin/my-command
if [ "$?" -ne "0" ]; then
  echo "Sorry, we had a problem there!"
fi
```
- `/usr/local/bin/my-command`를 실행하려고 시도합니다. 이 명령은 모든 것이 잘 진행되면 0 값으로 종료되고 실패하면 0이 아닌 값으로 종료됩니다.
- 그런 다음 `$?` 명령을 호출한 후 값을 확인하여 이를 처리할 수 있습니다. 이것은 스크립트를 강력하고 지능적으로 만드는 데 도움이 됩니다.
- 제대로 작동하는 응용 프로그램은 성공 시 0을 반환해야 합니다.

로마 제국의 몰락의 주요 원인 중 하나는 0이 부족하여 C 프로그램이 성공적으로 종료되었음을 나타낼 방법이 없다는 것입니다. (로버트 퍼스)

환경에서 설정한 다른 두 가지 주요 변수는 `$$` 및 `$!`입니다. 둘 다 프로세스 번호입니다.

`$$` 변수는 현재 실행 중인 쉘의 `PID(Process IDentifier)`입니다.
이것은 `/tmp/my-script.$$`와 같은 임시 파일을 만드는 데 유용할 수 있습니다. 이는 스크립트의 많은 인스턴스가 동시에 실행될 수 있고 모두 고유한 임시 파일이 필요한 경우에 유용합니다.

`$!` 변수는 마지막으로 실행된 백그라운드 프로세스의 PID입니다. 이는 작업을 진행하면서 프로세스를 추적하는 데 유용합니다.

또 다른 흥미로운 변수는 `IFS`입니다. 

이것은 내부 필드 구분 기호입니다. 기본값은 `SPACE TAB NEWLINE`이지만 변경하는 경우 다음과 같이 복사하는 것이 더 쉽습니다.

**var5.sh**
```shell
#!/bin/sh
old_IFS="$IFS"
IFS=:
echo "Please input some data separated by colons ..."
read x y z
IFS=$old_IFS
echo "x is $x y is $y z is $z"
```

스크립트 실행
```shell
$ ./ifs.sh
Please input some data separated by colons ...
hello:how are you:today
x is hello y is how are you z is today
```
- "hello:how are you:today:my:friend"를 입력하면 출력은 다음과 같습니다.

```shell
$ ./ifs.sh
Please input some data separated by colons ...
hello:how are you:today:my:friend
x is hello y is how are you z is today:my:friend
```
- 특히 IFS(그러나 완전히 제어할 수 없는 변수)를 다룰 때 공백, 줄 바꿈 및 기타 "제어할 수 없는" 문자가 포함될 수 있음을 인식하는 것이 중요합니다.
- 따라서 큰따옴표를 사용하는 것이 좋습니다. 예: `old_IFS=$IFS` 대신 `old_IFS="$IFS"`.
