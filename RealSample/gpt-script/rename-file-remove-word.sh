#!/bin/bash

# 디렉토리 경로가 인자로 제공되었는지 확인합니다.
if [[ $# -eq 0 ]]; then
    echo "Usage: ${0} <directory_path>" >&2
    exit 1
fi

dir="$1"

# 제외시킬 단어 배열(공백으로 구분)
echo "Enter words to exclude (separated by spaces):"
read -a exclude_words

# 디렉토리안의 파일 이름 변경
cd "$dir" || exit
for file in *.*; do
    # file 이 일반적인 파일인지 확인(디렉토리는 안됨), 확장자 없음
    if [[ -f "$file" ]]; then
        # 확장자없이 파일명 가져오기
        new_name=$(basename "$file" | sed 's/\.[^\.]*$//')
        # 파일 이름에서 제외시킬 단어 제거
        for word in "${exclude_words[@]}"; do
            # ${new_name//$word/} 구문을 사용하여 파일 이름에서 제외 단어를 제거
            new_name=$(echo "$new_name" | sed "s/$word//g")
        done

        new_name=$(echo "$new_name" | sed -E 's/^ +| +$//g;')

        # 새로운 파일 이름과 기존 파일 이름이 같다면 기존 파일 제거
        if [[ "$file" != "$new_name" ]]; then
            mv "$file" "$new_name.${file##*.}"
            echo "Renamed '$file' to '$new_name'"
        fi
    fi
done