#!/bin/bash

# 사용자에게 CSV 파일 경로와 출력 파일 이름을 입력하라는 메시지를 표시합니다.
read -rp "Enter the path to the CSV file: " csv_file
read -rp "Enter the name of the output file: " output_file

# CSV 파일 경로 유효성 검사
if [ ! -f "$csv_file" ]; then
    echo "Error: The specified CSV file does not exist."
    exit 1
fi

# output_file 파일명 유효성 검사
if [[ "$output_file" =~ [^a-zA-Z0-9\.\_\-] ]]; then
    echo "Error: The output file name contains illegal characters."
    exit 1
fi

# CSV 파일을 읽고 이름, 이메일, 전화번호 열을 추출합니다.
while IFS="," read -r name email phone
do
    # 이름과 성 추출
    first_name=$(echo "$name" | awk '{print $1}')
    last_name=$(echo "$name" | awk '{print $2}')
    
    # 연락처 정보 서식 지정
    contact_info=$(printf "    Email: %s\n    Phone: %s\n" "$email" "$phone")

    # 연락처 정보를 배열에 저장
    contacts+=("$last_name, $first_name" "$contact_info")
done < "$csv_file"

# 성을 기준으로 연락처 정렬하기
sorted_contacts=$(printf "%s\n" "${contacts[@]}")

# todo: sort 적용하면 데이터 순서가 다 바뀜.
# sorted_contacts=$(printf "%s\n" "${contacts[@]}" | sort -t ',' -k 1)

# 연락처를 필요한 구조의 텍스트 파일로 포맷합니다.
formatted_contacts=$(printf "%s\n---------------------\n%s\n" "Last Name, First Name" "${sorted_contacts[@]}")

# 사용자가 제공한 이름으로 텍스트 파일을 저장합니다.
echo "$formatted_contacts" > "$output_file"

echo "Contact list generated successfully in $output_file"