#!/bin/bash

# Iterate the loop for a fixed number of times

# 카운터 초기화
n=1

# 반복 루프를 5회 실행
while [ $n -le 5 ]
do
  # 각 반복에서 n을 출력
  echo "Running $n time"
  # 한번에 1씩 값을 증가
  (( n++ ))
done
