#!/bin/bash

# 사용자 입력 받기
echo '사용자 이름을 입력하세요:'
read username

# 입력된 사용자 이름 출력하기
echo "안녕하세요 $username 님!"

# 디렉토리 생성
echo '디렉토리 이름을 입력하세요:'
read dirname

mkdir "$dirname"
echo "$dirname 디렉토리가 생성 되었습니다."

# 파일 작성
echo '파일 이름을 입력하세요:'
read filename

echo '파일 내용을 입력하세요. 입력을 마치시려면 Ctrl+D를 누르세요.'
cat > "$dirname/$filename.txt"

echo
echo "$filename 파일이 작성되었습니다."