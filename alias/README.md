
# Alias 활용
> alias는 별칭이라는 뜻으로 리눅스에서 alias는 사용자가 명령어를 다른 이름으로 바꿔서 사용할 수 있는 쉘 내부 명령어를 말합니다. 이 alias를 통해서 일일이 입력하기 번거로운 길이가 긴 명령어를 간단한 이름으로 바꿔서 등록하여 업무 효율을 높일 수 있습니다.

## 명령어

| 명령어 | 설명 | 사용 예 |
| --- | --- | --- |
| alias | 현재 등록되어 있는 alias 보기 |
| alias 명령어별칭 = '명령어' | 명령어 alias(별칭) 등록 | alias flog='cd /log/myservice/info'</br></br>위의 예제처럼 등록하시면 flog라는 명령어만 입력해도 /log/myservice/info 위치로 바로 이동하실 수 있습니다. alias를 등록하실 때는 띄어쓰기를 주의해주세요. 명령어를 잘못 입력하시면 invalid alias name 오류가 납니다. |
| unalias 명령어별칭 | 명령어 alias(별칭) 해제 | unalias flog |

## alias 별칭 영구등록 
> 등록된 alias(별칭)들은 시스템을 재부팅하고 나면 다시 초기화가 되어 매번 재 설정해줘야 한다는 불편함이 있습니다. 그렇기에 이러한 문제를 방지하려면 alias를 ./bashrc 이나 .bash_aliases파일에 등록해서 사용하셔야 합니다. 이곳에다 등록해두면 재부팅되더라도 등록해둔 alias가 영구 지속됩니다.

```shell
# .bashrc 
alias cc='clear' 
# Source global definitions 
if [ -f /etc/bashrc ]; then
. /etc/bashrc 
fi 

# Uncomment the following line if you don't like systemctl's auto-paging feature: 
# export SYSTEMD_PAGER= 
# User specific aliases and functions ~
```
- bashrc 파일에 alias 명령어는 위와 같이 추가해주시면 됩니다.

```shell
source ~/.bashrc
```
- bashrc 파일을 수정한다고해서 바로 적용되는 건 아니고 source 명령어를 사용하여 동기화를 시켜주셔야 적용이 됩니다.
- 이러한 과정을 마친다면 자신이 등록해놓은 명령어를 alias 별칭으로 편하게 명령어를 수행하실 수 있습니다.

### 참고
- [[Linux] 리눅스 alias(명령어 별칭) 설정 및 사용법 (+ 영구 등록)](https://coding-factory.tistory.com/800)
- [Alias 설정하기](https://ojava.tistory.com/153)