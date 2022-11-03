# Exercises - Addressbook

## 요구사항
- 주소록 검색 
- 항목 추가 
- 항목 제거/편집

또한 선택 시 레코드를 표시하려면 "디스플레이" 기능이 필요합니다.

### Search
- 사용자가 "Smith"를 검색하면 스크립트는 모든 "Smith" 레코드를 식별하고 표시해야 합니다. 이 검색이 성에만 있는지 아니면 전체 레코드에서 검색되는지는 귀하에게 달려 있습니다.

### Add
- 데이터(이름, 성, 이메일, 전화 등)를 입력합니다. 
- 중복된 것으로 보이면 기존 기록을 편집할 수 있는 보너스 포인트를 제공합니다. 
- 사용자가 확인하면 기록을 데이터 파일에 저장합니다.

### Remove
- 검색 기준을 입력하고 하나로 좁혀 확인한 다음 해당 레코드를 제거합니다.

### Edit
- 제거할 때 기본 항목에 대해 기존 레코드를 사용합니다.

예를 들어 전화 번호를 변경하면 John Smith의 전화 번호만 변경하려는 경우 세션이 다음과 같이 표시될 수 있습니다.

```shell
Name [ John Smith ]
Phone [ 12345 ] 54321
Email [ joe@smith.org.uk ]
```
- 이전 레코드를 제거하고 새 레코드를 추가하십시오. 

또는 더 어려울 수 있지만 기존 레코드를 편집하십시오.

### Bonous Points
- 취소 옵션 허용("특수" 항목(^d, CR, ^c 등) 사용)
- "확인"옵션을 추가하십시오.
- 대화형/비대화형 모드를 제공합니다. (즉, 메뉴 기반 버전 및 명령줄(CLI) 기반 옵션.
- CLI 버전용 getopt로 플레이하십시오.

### Hints / Things to think about
- 권장 레코드 형식: 콜론을 사용하여 필드를 구분하십시오. 존 스미스: 54321:john@smith.example.com
- 그런 식으로 "cut -d:"를 사용하여 필드를 읽을 수 있습니다.
- 이 방법의 대안으로 IFS를 사용하는 것에 대해 생각해 보십시오.
- 공백(" ")을 사용하여 필드를 구분하고 입력의 공백을 밑줄("_")로 변환한 다음 표시를 위해 다시 변환하는 것에 대해 생각하십시오.

### 참고
- [Addressbook](https://www.shellscript.sh/exercises.html#addressbook)
- [[리눅스] trap을 이용한 signal 처리](https://12bme.tistory.com/604)