# 9. Case
> case 문은 if .. then .. else 문 전체 집합을 통해 저장합니다.

**talk.sh**
```shell
#!/bin/sh

echo "Please talk to me ..."
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	hello)
		echo "Hello yourself!"
		;;
	bye)
		echo "See you again!"
		break
		;;
	*)
		echo "Sorry, I don't understand"
		;;
  esac
done
echo 
echo "That's all folks!"
```

실행
```shell
$ ./talk.sh
Please talk to me ...
hello
Hello yourself!
What do you think of politics?
Sorry, I don't understand
bye
See you again!

That's all folks!
$
```

- 케이스 라인 자체는 항상 같은 형식이며, 이는 우리가 변수 INPUT_STRING의 값을 테스트하고 있음을 의미합니다.
- 그런 다음 우리가 이해하는 옵션이 나열되고 그 뒤에 hello) 및 bye)와 같이 오른쪽 대괄호가 옵니다.
- 즉, INPUT_STRING이 hello와 일치하면 코드의 해당 섹션이 최대 이중 세미콜론까지 실행됩니다.
- INPUT_STRING이 bye와 일치하면 작별 메시지가 인쇄되고 루프가 종료됩니다. 스크립트를 완전히 종료하려면 break 대신 exit 명령을 사용합니다.
- 여기서 세 번째 옵션인 *)는 기본 포괄 조건입니다. 필수는 아니지만 테스트 변수가 가질 값을 알고 있다고 생각하더라도 디버깅 목적으로 종종 유용합니다.
- 전체 case 문은 esac로 끝난 후(case 거꾸로!) done으로 while 루프를 끝냅니다.

이는 케이스 조건만큼 복잡하지만 매우 유용하고 강력한 도구가 될 수 있습니다. 

다른 용도와 함께 쉘 스크립트에 전달된 매개변수를 구문 분석하는 데 자주 사용됩니다.
