# 14. Hints and Tips

[www.shellscript.sh/tips/](https://www.shellscript.sh/tips/)에서 최신 팁과 힌트를 확인하십시오.

아래 내용은 솔직히 말해서 다소 구식입니다. 이 웹사이트의 /tips 부분에는 더 많은 유용한 팁이 있습니다.

Unix는 텍스트 조작 유틸리티로 가득 차 있으며, 그 중 일부는 이제 이 튜토리얼의 이 섹션에서 논의할 것입니다. 이것의 중요성은 유닉스에서 거의 모든 것이 텍스트라는 것입니다.

생각할 수 있는 거의 모든 것이 텍스트 파일이나 명령줄 인터페이스(CLI)에 의해 제어됩니다. 쉘 스크립트를 사용하여 자동화할 수 없는 유일한 것은 GUI 전용 유틸리티 또는 기능입니다.

여기에 몇 가지 하위 섹션이 있습니다. 다음은 일반적인 조언, 힌트 및 팁입니다.

[CGI Scripting](https://www.shellscript.sh/cgi.html)

[Exit Codes and flow control](https://www.shellscript.sh/exitcodes.html)
[Simple Expect replacement](https://www.shellscript.sh/expect.html)

[Using trap](https://www.shellscript.sh/trap.html) to know when you've been interrupted - such as a CTRL-C, etc.

[Workaround for the 'echo -n' vs 'echo \c' dichotomy](https://www.shellscript.sh/echo.html)

내가 작성한 [실제 스크립트의 문서화된 예](https://www.shellscript.sh/speedtouchconf.html) - 사용자가 SpeedTouch 모뎀을 구성하는 데 도움이 되며 http://speedtouchconf.sourceforge.net/에서 사용할 수 있습니다.

우리는 이미 간단하지만 효과적인 cut 명령의 사용을 위에서 보여주었습니다. 우리는 여기에서 사용되는 보다 일반적인 외부 프로그램의 몇 가지 예를 논의할 것입니다.

`grep`은 쉘 스크립트 프로그래머에게 매우 유용한 유틸리티입니다. `grep`의 예는 다음과 같습니다.
```shell
#!/bin/sh
steves=`grep -i steve /etc/passwd | cut -d: -f1`
echo "All users with the word \"steve\" in their passwd"
echo "Entries are: $steves"
```
- 이 스크립트는 일치하는 항목이 하나만 있으면 괜찮아 보입니다. 그러나 /etc/passwd에 "steve"라는 단어가 포함된 두 줄이 있으면 대화형 셸이 표시됩니다.

```shell
$> grep -i steve /etc/passwd 
steve:x:5062:509:Steve Parker:/home/steve:/bin/bash
fred:x:5068:512:Fred Stevens:/home/fred:/bin/bash
$> grep -i steve /etc/passwd |cut -d: -f1
steve
fred
```

그러나 스크립트는 다음을 표시합니다.
```shell
Entries are: steve fred
```
- 결과를 변수에 넣어 NEWLINE을 공백으로 변경했습니다. sh 맨페이지는 $IFS의 첫 번째 문자가 이 용도로 사용될 것이라고 알려줍니다. IFS는 기본적으로 <space><tab><cr>입니다.
- NEWLINE을 유지하고 싶었을 수도 있습니다. 공백을 NEWLINE으로 만들면 더 좋아 보일 수 있습니다. 이것은 tr의 작업입니다.

```shell
#!/bin/sh
steves=`grep -i steve /etc/passwd | cut -d: -f1`
echo "All users with the word \"steve\" in their passwd"
echo "Entries are: "
echo "$steves" | tr ' ' '\012'
```
- tr은 공백을 8진수 문자 012(NEWLINE)로 변환했습니다. tr의 또 다른 일반적인 용도는 range를 사용하는 것입니다.
- 텍스트를 대문자 또는 소문자로 변환할 수 있습니다. 

예를 들면 다음과 같습니다.

```shell
#!/bin/sh
steves=`grep -i steve /etc/passwd | cut -d: -f1`
echo "All users with the word "steve" in their passwd"
echo "Entries are: "
echo "$steves" | tr ' ' '\012' | tr '[a-z]' '[A-Z]'
```
- 여기에 [a-z]의 번역을 [A-Z]로 추가했습니다. a-z 범위에는 A-Z와 정확히 같은 수의 값이 있습니다.
- 그러면 ASCII 범위 a-z에 해당하는 모든 문자를 A-Z로 변환할 수 있습니다. 즉, 소문자를 대문자로 변환합니다.
- `tr`은 실제로 이것보다 더 영리합니다. `tr [:lower:] [:upper:]` 는 이 작업을 잘 수행하고 아마도 더 읽기 쉽습니다.

## Cheating

두 가지 유용한 도구는 sed와 awk입니다. 이것들은 그 자체로 미니 프로그래밍 언어로 사용될 수 있는 매우 강력한 두 가지 유틸리티이지만, 매우 간단하고 특정한 이유로 셸 스크립트에서 자주 사용됩니다.

이것은 시스템이 큰 실행 파일(sed의 경우 52k, awk의 경우 110k)을 로드해야 한다는 것을 의미하지만 이는 하기 힘든 일이지만 좋은 작업자가 자신의 도구를 탓하지 않는 이유는 좋은 작업자가 올바른 도구를 사용하기 때문입니다.

그래서 아주 간단한 사용법으로 이 두 가지를 소개하겠습니다.

### Cheating with awk
텍스트 파일의 문자, 행 및 단어 수를 계산하는 wc를 고려하십시오. 출력은 다음과 같습니다.

```shell
$ wc hex2env.c
	    102	    189	    2306	hex2env.c
```
- 라인 수를 변수로 가져오려면 다음을 사용하면 됩니다.

```shell
NO_LINES=`wc -l file`
```
- 전체 줄에서 읽을 것입니다.
- 출력이 공백으로 채워지기 때문에 숫자 102를 문자열에 안정적으로 가져올 수 없습니다. 대신에 우리는 awk가 C의 scanf와 유사하게 작동한다는 사실을 사용합니다. 원하지 않는 공백을 제거합니다.
- 이것을 변수 $1 $2 $3 등에 넣습니다. 

그래서 우리는 이 구조를 사용합니다:

```shell
NO_LINES=`wc -l file | awk '{ print $1 }'`
```
- NO_LINES 변수는 이제 102입니다.

### Cheating with sed
또 다른 편리한 유틸리티는 스트림 편집기인 `sed`입니다. `Perl`은 정규 표현식을 다루는 데 매우 능숙하지만 쉘은 그렇지 않습니다. 따라서 `sed`를 호출하여 `s/from/to/g` 구문을 빠르게 사용할 수 있습니다. 

예를 들면 다음과 같습니다.

```shell
sed s/eth0/eth1/g file1 >  file2
```
- file1에 있는 eth0의 모든 인스턴스를 file2에 있는 eth1로 변경합니다.
- 단일 문자만 변경하는 경우 tr이 사용할 도구가 되어 더 작아서 로드가 더 빠릅니다.
- tr이 할 수 없는 또 다른 일은 파일에서 문자를 제거하는 것입니다.

```shell
echo ${SOMETHING} | sed s/"bad word"//g
```
- 이렇게 하면 ${SOMETHING} 변수에서 "bad word"라는 문구가 제거됩니다. "하지만 `grep`은 그렇게 할 수 있습니다!"라고 말하고 싶을 수도 있습니다. - grep은 전체 행만 처리합니다. 

다음 파일을 고려하십시오.
```
This line is okay.
This line contains a bad word. Treat with care.
This line is fine, too.
```
- Grep은 두 번째 줄 전체를 제거하고 두 줄짜리 파일만 남깁니다. sed는 파일을 다음과 같이 읽도록 변경합니다.

```shell
This line is okay.
This line contains a . Treat with care.
This line is fine, too.
```

## Telnet hint
이것은 내가 Sun의 Explorer 유틸리티에서 가져온 유용한 기술입니다. 텔넷은 더 이상 서버에서 사용되지 않지만 터미널 집중 장치와 같은 일부 네트워크 장치에서는 여전히 사용됩니다.

다음과 같은 스크립트를 작성하거나 자신의 스크립트를 작성하거나 명령줄에서 다음을 실행할 수 있습니다.
```shell
$ ./telnet1.sh | telnet
```

- 나는 몇몇 사람들이 이것에 대해 나에게 질문을 했고 꽤 복잡하고 부피가 큰 예상 코드 모음을 가리키는 경향이 있었습니다. 이 코드는 시스템 간에 이식성이 높아야 합니다(egrep이 있는 한).
- 시스템에서 작동하지 않으면 -q 스위치와 함께 GNU grep을 사용하거나 독점 grep을 사용하여 /dev/null로 직접 이동하십시오. 그래도 예상보다 설치가 훨씬 쉽습니다.

**telnet1.sh**
```shell
#!/bin/sh
host=127.0.0.1
port=23
login=steve
passwd=hellothere
cmd="ls /tmp"

echo open ${host} ${port}
sleep 1
echo ${login}
sleep 1
echo ${passwd}
sleep 1
echo ${cmd}
sleep 1
echo exit
```

그러나 Sun은 몇 가지 영리한 오류 검사 코드를 추가합니다.

```shell
$ ./telnet2.sh | telnet > file1
```

**telnet2.sh**
```shell
#!/bin/sh
# telnet2.sh | telnet > FILE1 
host=127.0.0.1
port=23
login=steve
passwd=hellothere
cmd="ls /tmp"
timeout=3
file=file1
prompt="$"

echo open ${host} ${port}
sleep 1
tout=${timeout}
while [ "${tout}" -ge 0 ]
do
    if tail -1 "${file}" 2>/dev/null | egrep -e "login:" > /dev/null
    then
        echo "${login}"
        sleep 1
        tout=-5
        continue
    else
        sleep 1
        tout=`expr ${tout} - 1`
    fi
done

if [ "${tout}" -ne "-5" ]; then
  exit 1
fi

tout=${timeout}
while [ "${tout}" -ge 0 ]
do
    if tail -1 "${file}" 2>/dev/null | egrep -e "Password:" > /dev/null
    then
        echo "${passwd}"
        sleep 1
        tout=-5
        continue
    else
      if tail -1 "${file}" 2>/dev/null | egrep -e "${prompt}" > /dev/null
      then
        tout=-5
      else
        sleep 1
        tout=`expr ${tout} - 1`
      fi
    fi
done

if [ "${tout}" -ne "-5" ]; then
  exit 1
fi

> ${file}

echo ${cmd}
sleep 1
echo exit
```
- 이 버전에서는 출력이 file1에 저장되며 이 파일은 실제로 스크립트에서 진행 상황을 확인하는 데 사용됩니다.
- `"> ${file}"`을 추가하여 파일에 수신된 출력이 로그인 프로세스가 아니라 명령의 출력일 뿐입니다.
