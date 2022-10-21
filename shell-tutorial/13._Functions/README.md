# 13. Functions

> Bourne 셸 스크립트 프로그래밍의 자주 간과되는 기능 중 하나는 스크립트 내에서 사용할 함수를 쉽게 작성할 수 있다는 것입니다. <br/>
> 이것은 일반적으로 두 가지 방법 중 하나로 수행됩니다. 간단한 스크립트를 사용하면 함수가 호출된 것과 동일한 파일에서 단순히 함수를 선언합니다.<br/>
> 그러나 스크립트 모음을 작성할 때 종종 유용한 기능의 "라이브러리"를 작성하고 해당 기능을 사용하는 다른 스크립트의 시작 부분에서 해당 파일을 소싱하는 것이 더 쉽습니다.<br/>
> 방법은 동일하지만 여기서는 주로 첫 번째 방법을 사용할 것입니다. 두 번째(라이브러리) 방법은 명령이 `. ./library.sh` 스크립트 시작 부분에 있습니다.

쉘 함수를 프로시저로 호출할지 아니면 함수를 호출할지에 대해 약간의 혼란이 있을 수 있습니다. 함수의 정의는 전통적으로 단일 값을 반환하고 아무 것도 출력하지 않는다는 것입니다.

반면에 프로시저는 값을 반환하지 않지만 출력을 생성할 수 있습니다. 쉘 함수는 둘 중 하나 또는 둘 다 수행하지 않을 수 있습니다. 일반적으로 쉘 스크립트에서는 함수라고 합니다.

함수는 다음 네 가지 방법 중 하나로 값을 반환할 수 있습니다.
- 변수의 상태 변경
- `exit` 명령을 사용하여 쉘 스크립트 종료
- `return` 명령을 사용하여 함수를 종료하고 제공된 값을 셸 스크립트의 호출 섹션에 반환합니다.
- c=`expr $a + $b`가 포착되는 것처럼 호출자가 포착할 stdout으로 에코 출력

이것은 `exit`가 프로그램을 중지하고 `return`이 호출자에게 제어를 반환한다는 점에서 C와 비슷합니다. 차이점은 쉘 함수는 전역 매개변수를 변경할 수 있지만 매개변수를 변경할 수 없다는 것입니다.

함수를 사용하는 간단한 스크립트는 다음과 같습니다.

**function.sh**
```shell
#!/bin/sh
# A simple script with a function...

add_a_user()
{
  USER=$1
  PASSWORD=$2
  shift; shift;
  # Having shifted twice, the rest is now comments ...
  COMMENTS=$@
  echo "Adding user $USER ..."
  echo useradd -c "$COMMENTS" $USER
  echo passwd $USER $PASSWORD
  echo "Added user $USER ($COMMENTS) with pass $PASSWORD"
}

###
# Main body of script starts here
###
echo "Start of script..."
add_a_user bob letmein Bob Holness the presenter
add_a_user fred badpassword Fred Durst the singer
add_a_user bilko worsepassword Sgt. Bilko the role model
echo "End of script..."
```
- 4행은 ()로 끝나는 함수 선언으로 자신을 식별합니다. 그 뒤에 {가 오고 일치하는 } 다음에 오는 모든 것이 해당 함수의 코드로 간주됩니다.
- 이 코드는 함수가 호출될 때까지 실행되지 않습니다. 함수는 읽혀지지만 실제로 호출될 때까지 기본적으로 무시됩니다.
- 이 예의 경우 useradd 및 passwd 명령에 echo가 접두사로 붙었습니다. 이는 올바른 명령이 실행되는지 확인하는 유용한 디버깅 기술입니다. 이는 또한 루트가 아니거나 시스템에 이상한 사용자 계정을 추가하지 않고도 스크립트를 실행할 수 있음을 의미합니다!

우리는 쉘 스크립트가 순차적으로 실행된다는 생각에 익숙했습니다. 함수에서는 그렇지 않습니다.

이 경우 `add_a_user` 함수를 읽고 구문을 확인하지만 명시적으로 호출될 때까지 실행되지 않습니다. 이것이 2014년의 Shellshock 버그가 작동하는 곳입니다.

함수 자체의 일부가 아니더라도 함수 정의 이후의 다른 명령이 실행되었습니다. 이에 대한 자세한 내용은 http://steve-parker.org/articles/shellshock/을 참조하십시오.

실행은 echo 문 "Start of script..."로 시작됩니다. 

다음 줄, add_a_user bob letmein Bob Holness는 함수 호출로 인식되므로 add_a_user 함수가 입력되고 환경에 특정 추가와 함께 실행을 시작합니다.

```shell
$1=bob
$2=letmein
$3=Bob
$4=Holness
$5=the
$6=presenter
```
- 따라서 해당 함수 내에서 `$1`이 함수 외부에 설정되는 것과 상관없이 `$1`은 bob으로 설정됩니다.
- 따라서 함수 내에서 "원본" `$1`을 참조하려면 함수를 호출하기 전에 `A=$1`과 같이 이름을 할당해야 합니다. 그런 다음 함수 내에서 $A를 참조할 수 있습니다.
- `$3` 이상의 매개변수를 `$@`로 가져오기 위해 `shift` 명령을 다시 사용합니다. 그런 다음 함수는 사용자를 추가하고 암호를 설정합니다. 그 효과에 대한 주석을 반향하고 주 코드의 다음 줄로 제어를 반환합니다.

## Scope of Variables
> 다른 언어에 익숙한 프로그래머는 쉘 함수의 범위 규칙에 놀랄 수 있습니다. 기본적으로 매개변수($1, $2, $@ 등) 외에 범위 지정이 없습니다.

다음과 같은 간단한 코드 세그먼트를 사용합니다.
**scope.sh**
```shell
#!/bin/sh

myfunc()
{
  echo "I was called as : $@"
  x=2
}

### Main script starts here 

echo "Script was called with $@"
x=1
echo "x is $x"
myfunc 1 2 3
echo "x is $x"
```

scope.sh b c로 호출되는 스크립트는 다음 출력을 제공합니다.

```shell
Script was called with a b c
x is 1
I was called as : 1 2 3
x is 2
```
- `$@` 매개변수는 함수가 호출된 방식을 반영하기 위해 함수 내에서 변경됩니다. 그러나 변수 x는 사실상 전역 변수입니다. myfunc가 이를 변경했으며 제어가 주 스크립트로 돌아갈 때 해당 변경 사항은 여전히 ​​유효합니다.
- 함수의 출력이 다른 곳에서 파이프되면 하위 셸에서 함수가 호출됩니다. 즉, `myfunc 1 2 3 | tee out.log`는 두 번째로 여전히 "x is 1"이라고 말합니다.
- 이것은 `myfunc()`를 파이프하기 위해 새로운 셸 프로세스가 호출되기 때문입니다. 이것은 디버깅을 매우 실망스럽게 만들 수 있습니다. Astrid에는 `| tee`가 추가되었을 때 갑자기 실패한 스크립트가 있었고 이것이 왜 그래야 하는지 즉시 명확하지 않습니다.
- `tee`는 파이프 왼쪽에 있는 기능 전에 시작되어야 합니다. `ls | grep foo`의 간단한 예를 사용하면 grep이 먼저 시작되어야 하며 ls가 시작되면 ls의 stdout에 연결된 stdin과 함께 시작되어야 합니다.
- 쉘 스크립트에서 쉘은 우리가 `tee`를 통해 파이프할 것이라는 것을 알기도 전에 이미 시작되었으므로 운영 체제는 `tee`를 시작한 다음 `myfunc()`를 호출하기 위해 새 쉘을 시작해야 합니다. 이것은 답답하지만 알아둘 가치가 있습니다.

함수는 호출된 값도 변경할 수 없습니다. 이는 스크립트에 전달된 매개변수가 아니라 변수 자체를 변경하여 수행해야 합니다. 아래예는 이것을 더 명확하게 보여줍니다.

```shell
#!/bin/sh

myfunc()
{
  echo "\$1 is $1"
  echo "\$2 is $2"
  # cannot change $1 - we'd have to say:
  # 1="Goodbye Cruel"
  # which is not a valid syntax. However, we can
  # change $a:
  a="Goodbye Cruel"
}

### Main script starts here 

a=Hello
b=World
myfunc $a $b
echo "a is $a"
echo "b is $b"
```
- 이 함수는 $a를 변경하므로 "Hello World" 메시지는 "Goodbye Cruel World"가 됩니다.

## Recursion
> 함수는 재귀적일 수 있습니다. 

다음은 factorial 함수의 간단한 예입니다.

**factorial.sh**
```shell
#!/bin/sh

factorial()
{
  if [ "$1" -gt "1" ]; then
    i=`expr $1 - 1`
    j=`factorial $i`
    k=`expr $1 \* $j`
    echo $k
  else
    echo 1
  fi
}


while :
do
  echo "Enter a number:"
  read x
  factorial $x
done
```
- 약속한 대로 이제 쉘 스크립트 사이에서 라이브러리를 사용하는 것에 대해 간략하게 논의할 것입니다. 이것들은 우리가 보게 될 공통 변수를 정의하는 데에도 사용할 수 있습니다.

**common.lib**
```shell
# common.lib
# Note no #!/bin/sh as this should not spawn 
# an extra shell. It's not the end of the world 
# to have one, but clearer not to.
#
STD_MSG="About to rename some files..."

rename()
{
  # expects to be called as: rename .txt .bak 
  FROM=$1
  TO=$2

  for i in *$FROM
  do
    j=`basename $i $FROM`
    mv $i ${j}$TO
  done
}
```

**function2.sh**
```shell
#!/bin/sh
# function2.sh
. ./common.lib
echo $STD_MSG
rename .txt .bak
```

**function3.sh**
```shell
#!/bin/sh
# function3.sh
. ./common.lib
echo $STD_MSG
rename .html .html-bak
```
- 여기에서 우리는 각각 공통 라이브러리 파일 common.lib를 제공하고 해당 파일에 선언된 변수와 함수를 사용하는 두 개의 사용자 셸 스크립트 function2.sh 및 function3.sh를 봅니다.
- 이것은 너무 충격적인 내용이 아니며 쉘 프로그래밍에서 코드 재사용을 수행할 수 있는 방법의 한 예일 뿐입니다.

## Return Codes
> 종료 코드에 대한 자세한 내용은 자습서의 힌트 및 팁 섹션에서 종료 코드 부분을 참조하십시오. 지금은 `return` 콜을 간단히 살펴보겠습니다.

```shell
#!/bin/sh

adduser()
{
  USER=$1
  PASSWORD=$2
  shift ; shift
  COMMENTS=$@
  useradd -c "${COMMENTS}" $USER
  if [ "$?" -ne "0" ]; then
    echo "Useradd failed"
    return 1
  fi
  passwd $USER $PASSWORD
  if [ "$?" -ne "0" ]; then
    echo "Setting password failed"
    return 2
  fi
  echo "Added user $USER ($COMMENTS) with pass $PASSWORD"
}

## Main script starts here

adduser bob letmein Bob Holness from Blockbusters
ADDUSER_RETURN_CODE=$?
if [ "$ADDUSER_RETURN_CODE" -eq "1" ]; then
  echo "Something went wrong with useradd"
elif [ "$ADDUSER_RETURN_CODE" -eq "2" ]; then 
   echo "Something went wrong with passwd"
else
  echo "Bob Holness added to the system."
fi
```
- 이 스크립트는 두 개의 외부 호출(useradd 및 passwd)을 확인하고 실패 여부를 사용자에게 알립니다. 그런 다음 함수는 useradd에 문제가 있음을 나타내기 위해 반환 코드 1을 정의하고 passwd에 문제가 있음을 나타내기 위해 2를 정의합니다. 그렇게 하면 호출 스크립트가 문제가 있는 위치를 알 수 있습니다.
- 오랫동안 이 튜토리얼에서는 `$?`를 확인했습니다. `ADDUSER_RETURN_CODE=$?`를 설정하는 대신 두 번 모두 `ADDUSER_RETURN_CODE` 값을 확인합니다.
- `$?`를 저장해야 합니다. `if`와 같은 다른 명령을 실행하자마자 해당 값이 대체되기 때문입니다.
- 그렇기 때문에 컨텐츠에 대한 작업을 수행하기 전에 `$ADDUSER_RETURN_CODE` 변수에 `adduser` 반환 값을 저장합니다. `$ADDUSER_RETURN_CODE`는 동일하게 유지됩니다. `$?` 실행되는 모든 명령과 함께 변경됩니다.
