# 명령어 정리

| Command/Option | 설명 | 예시 | 예시 설명 |
| --- | --- | --- | --- |
| `cd [directory]` | 디렉토리 변경 | `cd Documents` | 현재 디렉토리를 Documents로 변경 |
| `ls [options] [directory]` | 디렉토리/파일 목록 출력 | `ls -a /home/user` | /home/user 디렉토리의 모든 파일 및 디렉토리, 숨겨진 파일 및 디렉토리 포함 |
| `mkdir [directory]` | 디렉토리 생성 | `mkdir project` | project라는 이름의 디렉토리 생성 |
| `rm [options] [file]` | 파일 삭제 | `rm -rf myfile.txt` | myfile.txt 파일을 강제로 삭제 |
| `cp [options] [source] [destination]` | 파일/디렉토리 복사 | `cp -r /home/user/docs /home/user/backup` | /home/user/docs 디렉토리를 /home/user/backup으로 복사 |
| `mv [options] [source] [destination]` | 파일/디렉토리 이동 또는 이름 변경 | `mv file.txt newfile.txt` | file.txt를 newfile.txt로 이름 변경 |
| `chmod [options] [mode] [file]` | 파일 권한 변경 | `chmod 755 myfile.txt` | myfile.txt 파일의 권한을 -rwxr-xr-x로 변경 |
| `chown [options] [user:group] [file]` | 파일 소유자 변경 | `chown user:group myfile.txt` | myfile.txt 파일의 소유자를 user:group으로 변경 |
| `grep [options] [pattern] [file]` | 파일 내에서 패턴 검색 | `grep "apple" myfile.txt` | myfile.txt 파일에서 "apple" 패턴 검색 |
| `sed [options] [expression] [file]` | 파일 내에서 패턴 변경 | `sed 's/apple/orange/g' myfile.txt` | myfile.txt 파일에서 "apple" 패턴을 "orange" 패턴으로 전체 변경 |
| `echo [options] [string]` | 문자열 출력 | `echo "Hello World"` | "Hello World" 문자열 출력 |
| `cat [options] [file]` | 파일 내용 출력 | `cat myfile.txt` | myfile.txt 파일 내용 출력 |
| `head [options] [file]` | 파일 앞부분 출력 | `head myfile.txt` | myfile.txt 파일의 처음 10줄 출력 |
| `tail [options] [file]` | 파일 뒷부분 출력 | `tail myfile.txt` | myfile.txt 파일의 마지막 10줄 출력 |
| `sort [options] [file]` | 파일 내용 정렬 | `sort myfile.txt` | myfile.txt 파일의 내용을 알파벳순으로 정렬 |
| `uniq [options] [file]` | 파일 중복 제거 | `uniq myfile.txt` | myfile.txt 파일의 중복된 내용 제거 |