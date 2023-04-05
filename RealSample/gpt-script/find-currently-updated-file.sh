#!/bin/bash

if [[ "${#}" -eq 0 ]]; then
    echo "Usage: ${0} [path]"
    exit 1
fi

# 경로 지정
path=$1

# 가장 최근에 수정된 파일 찾기
recent_file=$(find $path -type f -exec stat -f '%m %N' {} \; | sort -rn | head -1 | awk '{print $2}')

# 결과 출력
echo "가장 최근에 수정된 파일: $recent_file"

exit 0