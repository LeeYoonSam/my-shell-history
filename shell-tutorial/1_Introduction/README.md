# 1. Introduction

- 쉘에서 텍스트 파일 생성
- Hello World 출력하기

## echo
> echo 는 옵션으로 주어진 문자열을 터미널에 출력하는 명령어입니다.

### Sample
```shell
echo "this is a Dog"
```

### 참고
- [문자열을 출력하는 linux echo 명령어 사용법](https://www.lesstif.com/lpt/linux-echo-98271352.html)

--- 

## 리디렉션 연산자를 사용하여 파일에 쓰기

```shell
output > filename 
output >> filename 
```

**> 리디렉션 연산자**
> 리디렉션 연산자는 output을 지정된 파일에 씁니다.</br> 
> 파일이 있으면 길이가 0으로 잘립니다. 그렇지 않으면 파일이 생성됩니다.</br> 
> 이 연산자를 사용할 때는 중요한 파일을 덮어쓸 수 있으므로 각별히 주의하십시오.

**>> 리디렉션 연산자**
>> 리디렉션 연산자는 output을 지정된 파일에 추가합니다. 파일이 없으면 생성됩니다.

### Sample

```shell
echo "this is a Dog" > file.txt
echo "this is a Cat" >> file.txt
```
- file.txt 에 this is a Dog 를 씁니다.
- file.txt 에 this is a Cat 을 추가합니다.

---

## chmod
> chmod 명령은 파일의 권한을 변경할 수 있게 만들어주는 명령입니다.</br>
> "change"와 "mode"의 앞 글자들을 조합한 이름 입니다.(chmod = ch + mod)

리눅스에서, 파일(File)을 사용해 할 수 있는 작업은 크게 세 가지로 나눌 수 있습니다.
- 파일에 저장된 데이터를 읽기. (r = read).
- 파일에 데이터를 쓰기. (w = write).
- 파일 실행. (x = execute)

그런데 만약 리눅스 시스템의 모든 파일이, 그 종류 또는 쓰임새와 관계없이 읽기, 쓰기, 실행 가능하게 만들어져 있다면 어떻게 될까요? 잘못된 명령어 사용으로 시스템 운영에 중요한 역할을 하는 파일의 내용이 변경되거나, 사용자의 사소한 실수 한번으로 리눅스 시스템의 모든 파일이 삭제되어 버릴 수도 있습니다.

이런 문제가 생기는 경우를 방지하기 위해, 리눅스에서는 각 파일 및 디렉토리에 대해 "읽기(r)", "쓰기(w)", "실행(x)" 권한(permission)을 파일 개별적으로 지정할 수 있도록 만들어 놓았습니다. 그리고 이 세 가지 권한을 "파일을 소유한 사용자(user)", "특정 그룹(group)에 소속된 사용자", "그 외 사용자(others)"에 대해 각각 지정할 수 있게 만들었습니다.

파일을 소유한 사용자(user), 특정 그룹(group)에 소속된 사용자, 그 외 사용자(others)
- Read
- Write
- eXecute

### chmod 명령
앞서 설명했듯이 chmod 명령은 파일의 모드(mode)를 변경하는 명령입니다. chmod 다음에 `선택 옵션`과 `모드를 나타내는 문자열`, 그리고 `대상 파일(또는 디렉토리)`을 순서대로 입력하여 파일의 모드를 변경할 수 있습니다.

```
chmod [OPTION] [MODE] [FILE]
    OPTION
    -v        : 모든 파일에 대해 모드가 적용되는 진단(diagnostic) 메시지 출력.
    -f        : 에러 메시지 출력하지 않음.
    -c        : 기존 파일 모드가 변경되는 경우만 진단(diagnostic) 메시지 출력.
    -R        : 지정한 모드를 파일과 디렉토리에 대해 재귀적으로(recursively) 적용.
    MODE
    파일에 적용할 모드(mode) 문자열 조합.
        u,g,o,a : 소유자(u), 그룹(g), 그 외 사용자(o), 모든 사용자(a) 지정.
        +,-,=   : 현재 모드에 권한 추가(+), 현재 모드에서 권한 제거(-), 현재 모드로 권한 지정(=)
        r,w,x   : 읽기 권한(r), 쓰기 권한(w), 실행 권한(x)
        X       : "디렉토리" 또는 "실행 권한(x)이 있는 파일"에 실행 권한(x) 적용.
        s       : 실행 시 사용자 또는 그룹 ID 지정(s). "setuid", "setgid".
        t       : 공유모드에서의 제한된 삭제 플래그를 나타내는 sticky(t) bit.
        0~7     : 8진수(octet) 형식 모드 설정 값.
```

파일이 속한 그룹이 실행할 수 있는 권한 추가.
- `$ chmod  g+x  FILE`

시스템의 모든 사용자가 읽을 수만 있는 권한 지정.
- `$ chmod  a=r  FILE`

파일을 소유한 그룹과 그 외 사용자의 모든 권한 제거.
- `$ chmod  go-rwx  FILE`

### 8진수(octal) 형식으로 파일 모드(mode) 지정 방법
> 앞서 설명한 내용보다 조금 더 간단하게 파일 모드(mode)를 지정하는 방법이 있습니다.</br>
> 바로, MODE 파라미터에 파일 모드(mode)를 표현하는 8진수 값을 사용하는 것입니다.

- `8진수` 값을 사용하는 방법은 각 권한(rwx)을 8진수 형태의 숫자 값으로 변환하여 한번에 지정하는 방법입니다. 
- 즉, 그림의 "rwxrwxrwx" 중 "rwx"를 하나의 8진수 값으로 변환한 다음, 이 값을 연속 세 개(사용자, 그룹, 그 외 사용자)로 나열하여 전달하는 것입니다. 
- 권한 없음(-)은 0, 읽기(r)는 4, 쓰기(w)는 2, 실행(x)은 1에 해당하는 값을 가지며, 이 값들을 모든 더한 값이 하나의 8진수 값으로 변환됩니다.

**코드 예**
모든 사용자가 읽고 쓰고 실행할 수 없도록 지정.
- `$ chmod  000  FILE`
- ---------- 1 ppotta manager   23 Mar 26 04:13 FILE

모든 사용자가 읽고 쓰고 실행할 수 있는 권한 지정.
- `$ chmod  777  FILE`
- -rwxrwxrwx 1 ppotta manager   23 Mar 26 04:13 FILE

소유자는 모든 권한, 그룹 및 그 외 사용자는 읽기와 실행만 가능.
- `$ chmod  755  FILE`
- -rwxr-xr-x 1 ppotta manager   23 Mar 26 04:13 FILE

소유자 및 그룹은 읽기 가능, 그외 사용자는 권한 없음.
- `$ chmod  440  FILE`
- -r--r----- 1 ppotta manager   23 Mar 26 04:13 FILE

### chmod 명령 사용 예제
```
$ chmod u+x FILE                    # 파일 소유 사용자에게 실행권한 추가.

$ chmod u+w FILE                    # 파일 소유 사용자에게 쓰기 권한 추가.

$ chmod u=rwx FILE                  # 파일 소유 사용자에게 읽기, 쓰기, 실행 권한 지정.

$ chmod u-x FILE                    # 파일 소유 사용자의 실행 권한 제거.

$ chmod g+w FILE                    # 파일 소유 그룹에 쓰기 권한 추가.

$ chmod g-x FILE                    # 파일 소유 그룹의 실행 권한 제거.

$ chmod o=r FILE                    # 파일 소유 사용자 및 그룹을 제외한 사용자는 읽기만 가능.

$ chmod a-x *                       # 현재 디렉토리의 모든 파일에서 모든 사용자의 읽기 권한 제거.

$ chmod a-w FILE                    # 모든 사용자에 대해 쓰기 권한 제거.

$ chmod u=rwx,g=r FILE              # 파일 소유 사용자는 모든 권한, 그룹은 읽기만 가능.

$ chmod ug=rw FILE                  # 파일 소유 사용자와 그룹이 읽기, 쓰기 가능.

$ chmod g=rw,o=r FILE               # 파일 소유 그룹은 읽기, 쓰기 가능, 그 외 사용자는 읽기만 가능.

$ chmod ug=rw,o=r FILE              # 파일 소유 사용자 및 그룹은 일기, 쓰기 가능, 그외 사용자는 읽기만 가능.

$ chmod 000 FILE                    # 모든 사용자의 모든 권한 제거. = ---------

$ chmod 664 FILE                    # 사용자(읽기+쓰기), 그룹(읽기+쓰기), 그외 사용자(읽기) = rw-rw-r--

$ chmod 755 FILE                    # 사용자(읽기+쓰기+실행), 그룹(읽기+실행), 그외 사용자(읽기+실행) = rwxr-xr-x

$ chmod 777 FILE                    # 모든 사용자에 모든 권한 추가.

$ chmod -R g+x DIR                  # DIR 디렉토리 하위 모든 파일 및 디렉토리에 그룹 실행(x) 권한 추가.

$ chmod -R o-wx *                   # 현재 디렉토리의 모든 파일에서 그외 사용자의 쓰기, 실행 권한 제거

$ chmod -R a-x,a+X *                # 현재 디렉토리 기준 모든 파일 읽기 권한 제거, 디렉토리 실행 권한 추가.

$ chmod -R a-x+X *                  # 위(chmod -R a-x,a+X *)와 동일.

$ chmod u=g FILE                    # FILE의 그룹 권한 값을 사용자 권한으로 적용.
    $ ls -l
    -rwxr--r-- 1 ppotta manager   23 Mar 26 04:13 FILE
    $ chmod u=g FILE
    -r--r--r-- 1 ppotta manager   23 Mar 26 04:13 FILE

$ chmod u+g FILE                    # FILE의 사용자 권한에 그룹 권한 값을 추가.
    $ ls -l
    -r-x-w--w- 1 ppotta manager   23 Mar 26 04:13 FILE
    $ chmod u+g FILE
    -rwx-w--w- 1 ppotta manager   23 Mar 26 04:13 FILE
```

### 참고
- [리눅스 chmod 명령어 사용법. (Linux chmod command) - 리눅스 파일 권한 변경.](https://recipes4dev.tistory.com/175)