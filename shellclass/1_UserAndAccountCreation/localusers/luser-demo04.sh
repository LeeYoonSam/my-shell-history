#!/bin/bash

# 스크립트의 목표 및 의도를 설정

# This script creates an account on the local system.
# You will be prompted for the account name and password.
# 목표는 로컬 시스템에 계정을 만들고 누구든지 스크립트를 실행하면 계정 이름과 암호를 입력하라는 메시지가 표시됩니다.

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name.
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user.(공백이 포함될수 있기 때문에 "" 로 감싸서 사용)
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Set the password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login.
passwd -e ${USER_NAME}

