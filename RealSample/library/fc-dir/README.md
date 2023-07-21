# Favorite Command(FC)
터미널에서는 특정 명령어나 실행했던 명령을 다시 찾아볼때가 많은데 history 로 찾아서 하기엔 번거롭기도 하고 이게 무엇인지 기억이 안나기도 한다.

[fav-dir](https://github.com/johngrib/fav-dir/tree/master) 에서 영감을 받아서 자주쓰는 명령어를 저장하고 사용하는데 목적을 두고 스크립트를 작성해 봅니다.

## Todo
- FC 도움말
- FC 메인 화면
- ~~FC 명령어 정의~~
- FC 저장
- FC 삭제
- FC 리스트
- root function(fc) 다른곳에서 어떻게 실행하는지 리서치
- fzf 가 무엇인가?
- local 에 설치하는 방법
- home brew 배포

## FC 명령어 정의
명령어 | 옵션 | 설명
--- | --- | ---
fc | | 명령어 선택화면으로 이동
add, a | | 명령 저장
remove, rm | | 명령 삭제
clean, c | | 디스크에 존재하지 않는 경로를 즐겨찾기 목록에서 제거합니다.
list, l | | 명령 리스트 표시
find, f | -n | -n 이름으로 시작하는 명령 찾기
help | | FC 도움말 표시

## 구현시 사용한 명령어 정리

명령어 | 옵션 | 설명
--- | --- | ---
grep | -v, --invert-match | 선택된 줄은 지정된 패턴과 일치하지 않는 줄입니다.