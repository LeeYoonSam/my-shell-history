#!/bin/bash
# tr 명령어: 문자열을 변환하는 유용한 명령어입니다. 이 스크립트에서는 알파벳과 숫자를 포함한 모든 문자를 문자열에서 삭제하고 새로운 문자열을 생성하기 위해 사용됩니다.
#   -d 옵션은 문자열에서 특정 문자를 삭제하도록 지정하고, 
#   -c 옵션은 지정한 문자 집합의 보충집합을 선택합니다.
# fold 명령어: 긴 텍스트 라인을 자르거나 접을 때 사용하는 명령어입니다. 이 스크립트에서는 새로 생성된 비밀번호를 $length 자리씩 나누기 위해 사용됩니다.
# head 명령어: 파일의 처음 몇 줄을 출력하는 명령어입니다. 이 스크립트에서는 새로 생성된 비밀번호의 첫 3줄을 출력하기 위해 사용됩니다.
# read 명령어: 사용자 입력을 받기 위해 사용됩니다. 이 스크립트에서는 사용자가 원하는 비밀번호 길이를 입력하도록 요청하기 위해 사용됩니다.

echo '비밀번호 생성기'
echo '----------------'

echo -n '길이를 입력하세요: '
read length

password=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | fold -w $length | head -n 1)

echo "생성된 비밀번호: $password"