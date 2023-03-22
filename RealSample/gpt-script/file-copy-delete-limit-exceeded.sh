#!/bin/bash

# 파일을 백업할 경로를 지정합니다.
base_backup_folder="Backup/"

# 백업하려는 파일의 경로를 정의합니다.
file1="file1.txt"
file2="file2.txt"

# 현재 날짜와 시간을 폴더 이름으로 사용하여 백업 경로에 새 폴더를 만듭니다.
# date 명령은 현재 날짜와 시간을 YYYY-MM-DD_HH-MM-SS 형식으로 생성하는 데 사용됩니다. 
# () 구문은 명령을 실행하고 그 출력을 값으로 반환하는 데 사용됩니다.
backup_folder="$base_backup_folder$(date +%Y-%m-%d_%H-%M-%S)/"

# mkdir 명령을 사용하여 새 백업 폴더를 만듭니다.
mkdir "$backup_folder"

# 다음 두 줄은 cp 명령을 사용하여 백업하려는 파일을 외장 하드 드라이브의 새 폴더에 복사합니다.
cp "$file1" "$backup_folder"
cp "$file2" "$backup_folder"

# 백업 폴더의 크기를 확인하고 백업 경로에 공간이 부족할 경우 가장 오래된 백업 폴더를 삭제합니다. 
# du 명령은 사람이 읽을 수 있는 형식(-sh 옵션)으로 백업 폴더의 크기를 계산하는 데 사용됩니다. 
# head 명령은 가장 오래된 폴더를 선택하는 데 사용되며(head -n 1), 
# rm 명령은 가장 오래된 폴더를 삭제하는 데 사용됩니다(-rf 옵션).
max_size="10485760" # 10MB

# 백업 폴더의 크기 확인
backup_size=$(du -s "$base_backup_folder" | cut -f1)

# 백업 폴더의 크기가 max_size 를 초과하면 오래된 폴더부터 삭제
while [ "$backup_size" -gt "$max_size" ]
do
  # 백업 폴더를 리스트로 나열하고 가장 오래된것을 하나 선택
  oldest_folder=$(find "$base_backup_folder" -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo "$(stat -f "%m" "$0") $0"' {} \; | sort -n | head -n1 | cut -d' ' -f2-)

  # 가장 오래된 백업 폴더를 삭제
  rm -rf "$oldest_folder"

  # 다시 backup_size 를 계산
  backup_size=$(du -s "$base_backup_folder" | cut -f1)
done