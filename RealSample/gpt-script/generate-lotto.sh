#!/bin/bash

echo '로또 번호 생성기'
echo '----------------'

for i in {1..6}
do
    lotto_nums[i]=$(( RANDOM % 45 + 1 ))
    echo "${lotto_nums[*]}"

    for random_num in $(seq 1 $((i-1)))
    do
        # "${lotto_nums[*]}" =~ "${random_num}"는 모든 원소를 하나의 문자열로 합치고 공백을 추가한 것입니다. 
        # "${random_num}"도 문자열로 변환합니다.
        # =~ 연산자를 사용하여 $lotto_nums 문자열에 $random_num 문자열이 포함되어 있는지 확인합니다. 
        # 이렇게 하면 배열의 원소와 비교하는 데에도 안전하게 사용할 수 있습니다.
        if [[ "${lotto_nums[*]}" =~ ${random_num} ]]
        then
            # echo '중복 발생'
            i=$((i-1))
            break
        fi
    done
done

echo "당첨 번호: ${lotto_nums[1]} ${lotto_nums[2]} ${lotto_nums[3]} ${lotto_nums[4]} ${lotto_nums[5]} ${lotto_nums[6]}"