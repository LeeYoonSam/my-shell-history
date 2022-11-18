# [6. Useful Command Examples](https://learn.openwaterfoundation.org/owf-learn-linux-shell/useful-commands/useful-commands/)

이 페이지에서는 유용한 Linux 명령의 예를 제공합니다. 

명령은 명령줄에서 실행하거나 셸 스크립트에서 사용할 수 있습니다.

- [Count Matching String in Files](#count-matching-string-in-files)
- [Find File Differences](#find-file-differences)
- [Search Files for a String](#search-files-for-a-string)
- [Search for Files](#search-for-files)

---

## Count Matching String in Files
예를 들어 문자열이 포함된 파일 수와 같이 일치하는 인스턴스를 세는 것이 자주 도움이 됩니다.

주의가 필요한 패턴에 대한 코드를 검색하는 데 사용할 수 있습니다.

다음은 grep 명령을 사용하여 문자열을 검색하고 현재 폴더의 모든 파일에 대해 일치하는 파일 수를 계산합니다.

`wc(단어 수)` 명령은 `-l`과 함께 사용되어 행 수를 계산합니다. 

검색을 수정하려면 검색 명령의 예를 참조하십시오.
```sh
$ grep 'somestring' * | wc -l
```

문자열을 검색하려면 대소문자를 무시하고 모든 하위 폴더를 재귀적으로 검색합니다.
```sh
$ grep -ir 'somestring' | wc -l
```

문자열을 검색하려면 대소문자를 무시하고 모든 하위 폴더를 재귀적으로 검색하고 'somestring2'도 포함하는 행을 무시합니다.
```sh
$ grep -ir 'somestring' | grep -v 'somestring2' | wc -l
```

## Find File Differences
> 파일 차이점 찾기

Linux `diff` 명령은 파일 차이에 대한 텍스트 표현을 제공합니다. 전체 사용법은 `diff` 매뉴얼 페이지를 참조하십시오.

```sh
$ diff file1 file2
```

## Search Files for a String
> 줄 끝을 무시하고 파일 비교

Linux는 줄 끝으로 LF를 사용하는 반면 Windows는 CR LF를 사용합니다. 다른 운영 체제의 파일에서 diff를 실행하면 모든 줄이 다르게 표시됩니다. 

줄 끝을 무시하려면:
```sh
$ grep -ir 'pattern'
$ grep -ir 'error'
```

다음은 오류 문자열을 포함하여 찾은 다음 -v 옵션을 사용하여 도움말이 포함되지 않은 파일로 목록을 필터링합니다.
```sh
$ grep -ir 'error' | grep -v 'help'
```

## Search for Files
> 파일 검색

Linux find 명령은 리터럴 문자열 또는 패턴과 일치하는 이름을 가진 파일을 검색하는 데 사용됩니다. 

예를 들어 다음을 사용하여 로그 파일을 찾고 현재 폴더(.) 이하를 검색합니다.
```sh
$ find . -name '*.log'
```

다음은 빈 폴더를 찾는 데 사용되며 버전 관리를 위해 Git을 사용할 때 유용합니다. 

예를 들어 Git은 변경 사항이 있음을 나타낼 수 있지만 git status는 변경 사항을 나열하지 않습니다.
```sh
$ find . -type d -empty
```

`find` 명령 옵션을 사용하면 파일을 일치시키고 필터링하기 위한 다른 많은 선택 사항을 사용할 수 있습니다.
