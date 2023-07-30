# Favorite Command Collection(FCC)
터미널에서는 특정 명령어나 실행했던 명령을 다시 찾아볼때가 많은데 history 로 찾아서 하기엔 번거롭기도 하고 이게 무엇인지 기억이 안나기도 한다.

[fav-dir](https://github.com/johngrib/fav-dir/tree/master) 에서 영감을 받아서 자주쓰는 명령어를 저장하고 사용하는데 목적을 두고 스크립트를 작성해 봅니다.

## Todo
- ~~FCC 도움말~~
- ~~FCC 메인 화면~~
- ~~FCC 명령어 정의~~
- FCC 저장
    - ~~명령어 저장~~
    - ~~명령어를 fzf 로 보이게 처리하기~~
    - ~~명령어 클릭시 실행~~
    - ~~명렁어 저장시 history 앞 구분자 빼고 다 저장하기~~
    - ~~이미 저장된 명령어 알려주기~~
- ~~FCC 삭제~~
- ~~FCC 리스트~~
- FCC 기능 개선
    - ~~저장할 명령어를 history 에서 찾기 (add 와 구분해야 할지 고민)~~
    - 데이터셋 변경 (id, category, command, description 등)
    - 수정기능 추가
    - 파라미터 받아서 커맨드 실행
    - 명령어 저장시 옵셔널로 설명 추가
- ~~root function(fc) 다른곳에서 어떻게 실행하는지 리서치~~
- ~~fzf 가 무엇인가?~~
- ~~local 에 설치하는 방법~~
- home brew 배포

## FCC 명령어 정의
명령어 | 옵션 | 설명
--- | --- | ---
fcc | | 명령어 선택화면으로 이동
add, a | | 명령 저장
select, s | | 명령 저장(최근 히스토리 10개 내에서 선택)
remove, rm | | 명령 삭제
clean, c | | 디스크에 존재하지 않는 경로를 즐겨찾기 목록에서 제거합니다.
list, l | | 명령 리스트 표시
help | | FC 도움말 표시

## [fzf](https://github.com/junegunn/fzf)
> fzf는 범용 명령줄 퍼지 파인더입니다.<br>
파일, 명령 기록, 프로세스, 호스트 이름, 북마크, git 커밋 등 모든 목록에 사용할 수 있는 명령줄용 대화형 유닉스 필터입니다.

- fzf 를 사용하면 검색이 지원되서 검색 기능을 넣을 필요가 없을듯 해서 fcc find 명렁어 제외

## local에 스크립트 설치하는 방법(스크립트 실행 상태)
- ``.bashrc``, ``.zshrc`` 등 rc 파일에 `which fcc` 등을 추가해서 항상 명령어를 실행할수 있는 상태를 만들어줘야 합니다.
- which 를 사용할때 명령어가 나오게 하려면 usr/local/bin 에 스크립트가 추가 되어 있어야 합니다.
- `/usr/local/bin` 디렉토리는 macOS를 포함한 유닉스 계열 운영 체제에서 필수적인 역할을 합니다. 사용자가 설치한 실행 파일(프로그램, 스크립트 및 바이너리)이 배치되는 표준 위치입니다.

### /usr/local/bin의 역할
**사용자 설치 실행 파일** 
- 소스 코드에서 소프트웨어를 컴파일 또는 설치하거나 macOS에서 Homebrew와 같은 패키지 관리자를 사용할 때 결과 실행 파일은 일반적으로 `/usr/local/bin` 디렉토리에 설치됩니다. 이렇게 하면 전체 경로를 지정하지 않고 명령줄에서 이러한 프로그램을 직접 실행할 수 있습니다.

**시스템 디렉토리보다 높은 우선 순위**
- `/usr/local/bin` 디렉토리는 /usr/bin 및 /bin과 같은 시스템 디렉토리에 비해 시스템의 PATH 환경 변수에서 더 일찍 배치됩니다. 즉, `/usr/local/bin`에 설치된 프로그램의 사용자 정의 버전이 있는 경우 이름이 충돌하는 경우 시스템에서 제공하는 버전보다 선호됩니다.

**시스템 패키지와 분리**
- `/usr/local/bin`을 사용자 설치 소프트웨어의 설치 위치로 사용하여 사용자 설치 패키지를 시스템 패키지와 분리하는 데 도움이 됩니다. 시스템 패키지는 패키지 관리자가 관리하며 일반적으로 사용자 수정용이 아닙니다.

**사용자의 쉬운 액세스**
- `/usr/local/bin`에 실행 파일을 배치하면 사용자가 전체 경로를 지정하지 않고도 이러한 프로그램에 편리하게 액세스할 수 있습니다. 사용자는 아무 디렉토리에서나 간단히 명령을 호출할 수 있으며 시스템은 `/usr/local/bin` 디렉토리에서 실행 파일을 찾습니다.

### Shell Script 설치
**스크립트를 /usr/local/bin으로 이동합니다.**
/usr/local/bin 디렉토리에 스크립트를 설치하려면 관리자 권한이 필요합니다. sudo 명령을 사용하여 스크립트를 `/usr/local/bin`으로 이동할 수 있습니다.


```bash
sudo cp fcc.sh /usr/local/bin/
```
- 사용자 암호를 입력하라는 메시지가 표시됩니다. 암호를 입력하면 스크립트가 /usr/local/bin 디렉토리로 복사됩니다.


**설치 확인**
이제 다음 명령을 실행하여 스크립트가 /usr/local/bin에 설치되어 있고 올바른 실행 권한이 있는지 확인할 수 있습니다.

```bash
ls -l /usr/local/bin/fcc.sh
```
- 출력에는 /usr/local/bin에 설치되었음을 나타내는 올바른 권한이 있는 스크립트가 표시되어야 합니다.


**스크립트를 실행합니다.**
이제 스크립트가 `/usr/local/bin` 디렉토리에 있으므로 이름을 부르기만 하면 시스템의 모든 위치에서 실행할 수 있습니다.

```bash
fcc.sh
```
- 스크립트가 실행되고 터미널에 스크립트 출력이 표시되어야 합니다.

**.bashrc, .zshrc 에 추가**
```bash
source $(which fcc.sh)
```

**fcc 실행**
```bash
fcc
fcc add
fcc help
```
- fcc 명령어로 실행

## FCC 저장
- 가장 최근에 입력한 명령어를 저장

## 구현시 사용한 명령어 정리

명령어 | 옵션 | 설명
--- | --- | ---
grep | -v, --invert-match | 선택된 줄은 지정된 패턴과 일치하지 않는 줄입니다.
!! | | 가장 최근에 입력한 명령을 가져옵니다.
awk | | `awk '{print $n}'` 명령은 입력 데이터의 각 레코드에서 n번째 필드를 추출하고 인쇄하는 데 사용됩니다.
history | -n | 최근에 실행한 명령어를 n개 조회
cut | -d | 구분자를 기준으로 필드를 분리
while | | while 루프를 시작합니다. 루프의 시작을 정의하고 지정된 조건이 참인 동안 루프가 계속됩니다.
while | IFS= | `내부 필드 구분자` 변수(IFS)를 빈 문자열로 설정합니다. 이것은 read 명령 중에 선행 및 후행 공백이 잘리는 것을 방지하는 데 사용됩니다. `IFS`를 빈 문자열로 설정하면 `read` 명령이 선행 및 후행 공백을 유지합니다.
while | read -r variable | read 명령은 입력 소스(예: 파일 또는 명령 출력)에서 한 줄을 읽고 변수 variable에 저장하는 데 사용됩니다. -r 옵션은 read에게 백슬래시를 문자 그대로 해석하여 특수 문자가 이스케이프되지 않도록 합니다.


## 발생한 문제

### 최근 명령어 저장시 발생한 문제

**[문제-미해결]**

```bash
adb devices
fcc add

current_command: adb
Added => adb
```
- fcc add > 실행시 앞쪽의 adb 만 저장되는 문제 발생
- `$(history -1 | awk '{print $2}')` awk 로 2번째 필드를 저장해서 발생한 문제

**[해결]**
```bash
history -1 | cut -d' ' -f4-
>adb devices
history -1 | cut -d' ' -f3-
> adb devices
history -1 | cut -d' ' -f2-
>1350  adb devices
history -1 | cut -d' ' -f1-
> 1352  adb devices
```
- history 1개만 가져와서 구분자를 공백으로해서 필드를 나누고 4번째 필드부터 출력

```bash
`$(history -1 | awk '{print $2}')` -> 
$(history -1 | cut -d' ' -f4-)
```

---

**[문제-미해결]**

- fcc > alias 로 등록된것을 실행시 command not found 에러 발생
- `__fcc_main:22: command not found: adb-c`

**[해결]**

---

**[문제]**

- !! 를 사용해서 가장 최근에 사용한 명령을 가져오려고 하니 명령어를 찾을수 없는 문제가 발생
- 터미널에서 !! 를 입력하면 커맨드에 이전 명령이 나타나고 엔터를 클릭하면 그 명령이 실행되지만 변수에 저장할수는 없었다.

**[해결]**

- history 를 1개만 가져와서 awk 를 사용해서 2번째 단락을 사용해서 해결
```bash
local CURRENT_COMMAND=$(history -1 | awk '{print $2}')
```

---

### 명령어 자체를 저장 하기
**[문제]**

```bash
$CURRENT_COMMAND > $INDEX.temp
```
- 명령어를 실행해서 나온 출력을 저장하게 되어서 원하는 명렁어 저장이 되지 않는 문제가 발생

**[해결]**

```bash
echo "$CURRENT_COMMAND" > $INDEX.temp
```
- 명령어 자체를 출력하기 위해 echo 를 사용해서 출력하고 그 결과를 명령어에 저장 하도록 처리


---

### 중복된 명령어 알리기
**[문제]**
- 명령어 저장시 이미 저장한 명령어 일때 피드백 제공

**[해결]**

```bash
echo "$CURRENT_COMMAND" > $INDEX.temp
```

```bash
function checkDuplicationCommand() {
    # 커맨드 정렬 및 중복 명령 찾기
    sorted_commands=$(sort $INDEX.temp)
    duplicate_commands=$(echo "$sorted_commands" | uniq -d)

    if [ -z "$duplicate_commands" ]; then
        __fcc_save_temp_to_index $1
    else
        # 중복된 라인 출력
        while IFS= read -r command; do
            IS_DUPLICATED=true
            echo "Duplicated => $command"
        done <<< "$duplicate_commands"
    fi
}
```
- `uniq -d`를 사용하여 중복 명령을 찾습니다. 중복 명령을 `duplicate_commands` 변수에 저장
- `duplicate_commands` 가 비어 있으면 명령어 저장, 비어 있지 않으면 중복 메시지 출력
- `__fcc_save_temp_to_index` 를 할때 현재 저장중인 명령어를 전달해서 저장한 후 출력하도록 변경


## Reference
- [rbenv](https://github.com/rbenv/rbenv) : README.md 에서 OS 나 shell 환경별 설정 참고