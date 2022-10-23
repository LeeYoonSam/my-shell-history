# 16. Interactive Shell

다음은 UNIX 또는 Linux 셸을 대화식으로 사용하기 위한 몇 가지 간단한 힌트입니다.

개인적으로 나는 대부분의 대화식 사용을 위해 bash 셸을 권장합니다. 거의 모든 *nix 버전에서 사용할 수 있으며 로그인 셸로 사용하기에 매우 좋습니다.

그러나 루트 셸은 bash 또는 Bourne 셸을 가리키든 항상 /bin/sh여야 합니다.

## bash
- bash에는 매우 편리한 기록 검색 도구가 있습니다. 위쪽 및 아래쪽 화살표 키는 이전 명령의 기록을 스크롤합니다.
- 더 유용하게는 Ctrl+r은 명령줄의 모든 부분과 일치하는 역 검색을 수행합니다. ESC 키를 누르면 선택한 명령이 필요에 따라 편집할 수 있도록 현재 셸에 붙여넣어집니다.

이전에 실행한 명령을 반복하고 어떤 문자로 시작했는지 알고 있다면 다음과 같이 할 수 있습니다.

```shell
bash$ ls /tmp
(list of files in /tmp)
bash$ touch /tmp/foo
bash$ !l
ls /tmp
(list of files in /tmp, now including /tmp/foo)
```
- 화살표 키뿐만 아니라 PageUp 및 PageDn을 사용하여 명령줄의 시작과 끝으로 이동할 수 있습니다.

## ksh
- vi 또는 emacs 모드에서 기록 명령을 추가하여 ksh를 더 유용하게 만들 수 있습니다. 상황에 따라 여러 가지 방법이 있습니다. 
- `set -o vi`, `ksh -o vi` 또는 `exec ksh -o vi`(여기서 "vi"는 emacs 모드를 선호하는 경우 "emacs"로 대체될 수 있음).

다른 대화형 쉘에서 ksh 세션을 시작하려면 다음과 같이 ksh를 호출하면 됩니다.

```shell
csh% # oh no, it's csh!
csh% ksh
ksh$ # phew, that's better
ksh$ # do some stuff under ksh
ksh$ # then leave it back at the csh prompt:
ksh$ exit
csh%
```
- 이렇게 하면 새 ksh 세션이 시작되며 이 세션을 종료하고 이전 셸로 돌아갈 수 있습니다. 또는 `exec` 명령을 사용하여 csh(또는 모든 셸)를 ksh 셸로 바꿀 수 있습니다.

```shell
csh% # oh no, it's csh!
csh% exec ksh
ksh$ # do some stuff under ksh
ksh$ exit

login:
```
- 여기서 차이점은 csh 세션을 다시 얻지 못한다는 것입니다.

좋은 점은 히스토리 입니다.

```shell
csh% ksh
ksh$ set -o vi
ksh$ # You can now edit the history with vi-like commands, 
  # and use ESC-k to access the history.
```
- `ESC`를 누른 다음 `k`를 누른 다음 `k`를 반복해서 누르면 명령 기록을 뒤로 스크롤합니다. 

vi 명령 모드 및 진입 모드 명령을 사용하여 다음과 같이 명령을 편집할 수 있습니다.

```shell
ksh$ touch foo
  ESC-k (enter vi mode, brings up the previous command)
  w (skip to the next word, to go from "touch" to "foo"
  cw (change word) bar (change "foo" to "bar")
ksh$ touch bar
```