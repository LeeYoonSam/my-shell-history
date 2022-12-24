# Local Users

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

## Variables
```sh
WORD='script'

echo "WORD" # -> script
echo 'WORD' # -> $WORD
```
- 구체적이고 아무 것도 변경되지 않도록 하려면 작은따옴표를 사용하십시오.

--- 
 # 13. Special Variables, Pseudocode, Command Substitution, if Statement, Conditionals.

**배울내용**
- 쉘이 생성하는 몇 가지 특수 변수
- 변수에 있는 명령의 출력
- if 문

