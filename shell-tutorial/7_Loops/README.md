# 7. Loops
> 대부분의 언어에는 루프의 개념이 있습니다. 작업을 20번 반복하려는 경우 매번 약간의 변경으로 코드를 20번 입력할 필요가 없습니다.<br/>
> 결과적으로 Bourne 셸에 for 및 while 루프가 있습니다.

## For Loops
> for 루프는 목록이 소진될 때까지 값 집합을 반복합니다.

**for.sh**
```shell
#!/bin/sh
for i in 1 2 3 4 5
do
  echo "Looping ... number $i"
done
```

```shell
Looping .... number 1
Looping .... number 2
Looping .... number 3
Looping .... number 4
Looping .... number 5
```
- 이 코드를 실행하고 어떻게 결과가 나오는지 확인합니다. 값은 무엇이든 될 수 있습니다.

**for2.sh**
```shell
#!/bin/sh
for i in hello 1 * 2 goodbye 
do
  echo "Looping ... i is set to $i"
done
```
- \* 없이 시도하고 아이디어를 파악한 다음 와일드카드 섹션을 다시 읽고 *를 제자리에 놓고 다시 시도하십시오. 
- 다른 디렉토리에서도 시도해 보십시오. 
- *를 큰따옴표로 묶고 앞에 백슬래시(\\\*)를 붙이십시오.

```shell
Looping ... i is set to hello
Looping ... i is set to 1
Looping ... i is set to (name of first file in current directory)
    ... etc ...
Looping ... i is set to (name of last file in current directory)
Looping ... i is set to 2
Looping ... i is set to goodbye
```

현재 쉘에 접근할 수 없는 경우(이 튜토리얼을 읽는 동안 쉘을 가지고 있는 것이 매우 유용함)

보시다시피 `for`는 입력이 다 떨어질 때까지 주어진 입력을 반복합니다.

---

## While Loops

**while.sh**
```shell
#!/bin/sh
INPUT_STRING=hello
while [ "$INPUT_STRING" != "bye" ]
do
  echo "Please type something in (bye to quit)"
  read INPUT_STRING
  echo "You typed: $INPUT_STRING"
done
```
- 여기서 일어나는 일은 echo 및 read 문은 프롬프트가 표시될 때 "bye"를 입력할 때까지 무기한 실행된다는 것입니다.
- [Variables Part1](../4_Variables_Part1/) 를 검토하여 테스트하기 전에 INPUT_STRING=hello를 설정한 이유를 확인하십시오. 이렇게 하면 전통적인 while 루프가 아닌 반복 루프가 됩니다.


콜론(:)은 항상 true로 평가됩니다. 이것을 사용하는 것이 때때로 필요할 수 있지만 종종 실제 종료 조건을 사용하는 것이 더 좋습니다.

위 루프를 종료하는 것과 아래 루프를 종료하는 것을 비교하십시오. 어느 것이 더 우아한지 보십시오. 또한 각각이 다른 것보다 더 유용할 몇 가지 상황을 생각해 보십시오.

**while2.sh**
```shell
#!/bin/sh
while :
do
  echo "Please type something in (^C to quit)"
  read INPUT_STRING
  echo "You typed: $INPUT_STRING"
done
```
- 또 다른 유용한 트릭은 while 읽기 루프입니다. 이 예제에서는 나중에 다룰 case 문을 사용합니다. myfile.txt 파일에서 읽고 각 줄에 대해 사용 중인 언어가 무엇인지 알려줍니다.
- 이것은 한 번에 한 줄씩 "myfile.txt" 파일을 "$input_text" 변수로 읽습니다. 그런 다음 case 문은 $input_text의 값을 확인합니다.
- myfile.txt에서 읽은 단어가 "hello"이면 "English"라는 단어를 에코합니다. "gday"인 경우 호주인을 울립니다.
- myfile.txt의 줄에서 읽은 단어(또는 단어)가 제공된 패턴과 일치하지 않으면 catch-all "*" 기본값은 "알 수 없는 언어: $input_text" 메시지를 표시합니다. 물론 여기서 " $input_text"는 myfile.txt에서 읽은 행의 값입니다.


**while3.sh**
```shell
#!/bin/sh
while read input_text
do
  case $input_text in
        hello)          echo English    ;;
        howdy)          echo American   ;;
        gday)           echo Australian ;;
        bonjour)        echo French     ;;
        "guten tag")    echo German     ;;
        *)              echo Unknown Language: $input_text
                ;;
   esac
done < myfile.txt
```
- myfile.txt 파일에 다음 다섯 줄이 포함되어 있다고 가정해 보겠습니다.

```shell
$ ./while3.sh
Unknown Language: this file is called myfile.txt and we are using it as an example input.
English
Australian
French
Unknown Language: hola
```

최근에 Linux From Scratch 프로젝트에서 배운 편리한 Bash(Bourne Shell 제외) 팁은 다음과 같습니다.

```shell
mkdir rc{0,1,2,3,4,5,6,S}.d
```

번거로운 대신:
```shell
for runlevel in 0 1 2 3 4 5 6 S
do
  mkdir rc${runlevel}.d
done
```

그리고 이것은 재귀적으로도 할 수 있습니다:
```shell
$ cd /
$ ls -ld {,usr,usr/local}/{bin,sbin,lib}
drwxr-xr-x    2 root     root         4096 Oct 26 01:00 /bin
drwxr-xr-x    6 root     root         4096 Jan 16 17:09 /lib
drwxr-xr-x    2 root     root         4096 Oct 27 00:02 /sbin
drwxr-xr-x    2 root     root        40960 Jan 16 19:35 usr/bin
drwxr-xr-x   83 root     root        49152 Jan 16 17:23 usr/lib
drwxr-xr-x    2 root     root         4096 Jan 16 22:22 usr/local/bin
drwxr-xr-x    3 root     root         4096 Jan 16 19:17 usr/local/lib
drwxr-xr-x    2 root     root         4096 Dec 28 00:44 usr/local/sbin
drwxr-xr-x    2 root     root         8192 Dec 27 02:10 usr/sbin
```

테스트 및 케이스 섹션에서 while 루프를 더 사용할 것입니다.