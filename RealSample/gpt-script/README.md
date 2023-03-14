# GPT 를 이용해서 추천받은 스크립트 샘플

## 1. [서버 모니터링 스크립트 예제](server-monitoring.sh)

### 기록
- mac 에서 사용중인걸 모르니 일반적인 스크립트를 작성
- `top -b -n 1` CPU 사용량 출력에서 mac 에서 지원하지 않는 옵션을 사용
    - 최종 변경 : `ps -e -o pid,command,%cpu,time | sort -nrk 3 | head`
- `free -m` 메모리 사용량 출력에서 기본적으로 설치되어 있지 않은 `free` 를 사용
    - 최종 변경 : `vm_stat` 명령어로 대체
