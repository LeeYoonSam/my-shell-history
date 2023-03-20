#!/bin/bash

if [ "${#}" -lt 1 ]
then
    echo 'Required parameters'
    echo "Usage: ${0} [Directory]"
    exit 1
fi

# 디렉토리 경로 입력
dir_path=$1

# 파일과 디렉토리 개수 초기화
file_count=0
dir_count=0

# 디렉토리 순회 함수
function traverse_dir() {
    # ex) "$1"/*; -> 해당 경로에 있는 path 전체 출력
    # echo ~/Downloads/*
    for item in "$1"/*; do
        if [[ -f "$item" ]]; then
            # 파일인 경우 파일 개수 증가
            ((file_count++))
        elif [[ -d "$item" ]]; then
            # 디렉토리인 경우 디렉토리 개수 증가 후 재귀호출
            ((dir_count++))
            traverse_dir "$item"
        fi
    done
}

# 디렉토리 순회 함수 호출
traverse_dir "$dir_path"

# 결과 출력
echo "File count: $file_count"
echo "Directory count: $dir_count"