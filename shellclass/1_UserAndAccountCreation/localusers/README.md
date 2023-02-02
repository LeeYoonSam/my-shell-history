# Local Users

## 시작시 공통으로 해야하는 작업
- 가상머신을 시작하고 연결
```shell
cd shellclass
cd localusers
vagrnat up
```
- 폴더 이동 후 가상머신 시작 및 연결

```shell
vagrant ssh
```
- ssh 접속

```shell
cd /vagrant
```
- 이제 가상 머신 내부에 있으므로 Slash Vagrant의 공유 디렉토리에 시드할 것입니다.


## Shell Script 표현식
Shell Script 표현식 | 부르는 이름
--- | ---
\# | Sharp
! | Bang
#! | shebang (shebang이라고 불리는 이유는 파운드 기호가 때때로 샤프라고 불리기 때문입니다.)


## 내장함수
| 명령어 | 설명 |
| --- | --- |
| type -a command | 시스템에서 Echo의 모든 인스턴스를 보려면 모두 A를 입력한 다음 echo를 입력합니다. |
| echo "some text" | 출력 |
| help echo \|less  | echo 에 대한 설명을 줄여서 보여줌 |

# [Section 3: User and Account Creation](./Section3/)
# [Section 4: Password Generation and Shell Script Arguments](./Section4/)
# [Section 5: Linux Programming Conventions](./Section5/)
# [Section 6: Parsing Command Line Options](./Section6/)
# [Section 7: Transforming Data / Data Processing / Reporting](./Section7/)