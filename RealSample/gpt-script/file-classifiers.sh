#!/bin/bash

# `$1` 구문을 사용하여 스크립트에 전달된 첫 번째 인수가 `dir` 변수에 할당됩니다. 스크립트 시작 부분의 `if` 문은 `$#` 구문(스크립트에 전달된 인수 수를 반환)을 사용하여 디렉토리 경로가 인자로 제공되었는지 확인하고 인수가 제공되지 않은 경우 오류 메시지와 함께 스크립트를 종료합니다.
# 다음 네 줄은 `mkdir` 명령을 사용하여 정리하려는 각 파일 유형에 대한 하위 디렉터리를 만듭니다.
# `for 루프는 와일드카드(*)` 구문을 사용하여 디렉터리의 각 파일을 반복합니다. 
    - if 문은 테스트 명령의 -d 옵션을 사용하여 파일이 디렉터리인지 확인합니다. 파일이 디렉터리인 경우 루프는 계속 명령을 사용하여 다음 파일로 건너뜁니다.
# `file` 명령은 각 파일의 MIME 유형을 결정하는 데 사용됩니다. `--mime-type` 옵션은 `MIME 유형` 출력 형식을 지정하는 데 사용됩니다. `b` 옵션은 파일 이름 없이 MIME 유형만 인쇄하는 데 사용됩니다.
# 루프의 if 문은 파일 명령의 출력을 사용하여 각 파일 유형에 적합한 하위 디렉터리를 결정합니다.
    - 파일의 MIME 유형이 특정 파일 유형(예: PDF, JPEG, MP3, MP4)과 일치하는 경우 mv 명령을 사용하여 파일을 적절한 하위 디렉터리로 이동합니다.
# 마지막 줄은 rmdir 명령을 사용하여 빈 하위 디렉터리를 삭제합니다. 2> /dev/null 구문은 rmdir 명령의 오류 출력을 null 장치로 리디렉션하는 데 사용됩니다.

# 디렉토리 경로가 인자로 제공되었는지 확인합니다.
if [[ $# -eq 0 ]]; then
    echo "Usage: organize_files.sh <directory_path>" >&2
    exit 1
fi

# 분류할 디렉터리 경로
dir="$1"

# 각 파일 유형에 대한 하위 디렉터리 만들기
documents="$dir/Documents"
images="$dir/Images"
music="$dir/Music"
videos="$dir/Videos"
etc="$dir/Etc"

mkdir -p "$documents"
mkdir -p "$images"
mkdir -p "$music"
mkdir -p "$videos"
mkdir -p "$etc"

# 파일 유형에 따라 적절한 하위 디렉터리로 파일을 이동합니다.
for file in "$dir"/*; do
    if [[ -d "$file" ]]; then
        continue # Skip directories
    fi
    if [[ $(file --mime-type -b "$file") == "application/pdf" ]]; then
        mv "$file" "$documents"
    elif [[ $(file --mime-type -b "$file") == "image/jpeg" || $(file --mime-type -b "$file") == "image/jpg" || $(file --mime-type -b "$file") == "image/png" ]]; then
        mv "$file" "$images"
    elif [[ $(file --mime-type -b "$file") == "audio/mpeg" || $(file --mime-type -b "$file") == "audio/wav" ]]; then
        mv "$file" "$music"
    elif [[ $(file --mime-type -b "$file") == "video/mp4" || $(file --mime-type -b "$file") == "video/quicktime" ]]; then
        mv "$file" "$videos"
    else
        mv "$file" "$etc"
    fi
done

# (선택 사항) 빈 하위 디렉터리 삭제
rmdir "$documents" "$images" "$music" "$videos" "$etc" 2> /dev/null