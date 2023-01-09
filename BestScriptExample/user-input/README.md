# Bash Script User Input

> 사용자로부터 입력을 받는 것은 모든 프로그래밍 언어의 일반적인 작업입니다.<br/>
여러 가지 방법으로 bash 스크립트에서 사용자로부터 입력을 받을 수 있습니다. 사용자로부터 데이터를 가져오기 위해 bash 스크립트에서 `read` 명령이 사용됩니다.<br/>
`read` 명령의 다른 옵션을 적용하여 bash 스크립트에서 단일 또는 다중 데이터를 가져올 수 있습니다. `read` 명령의 몇 가지 일반적인 용도는 이 자습서에 나와 있습니다.

## read 명령어 옵션
Option | Purpose
--- | ---
`-p` | 입력 프롬프트 전에 사용자에게 도움이 되는 메시지를 제공하기 위해 사용됩니다.
`-s` | 사용자로부터 보이지 않는 입력을 받는 데 사용됩니다. 이 옵션은 암호 또는 비밀 데이터를 가져오는 데 사용됩니다. 무음 모드라고 합니다.
`-t` | 사용자의 입력을 기다리는 시간을 초 단위로 설정하는 데 사용됩니다.
`-n` | 입력 문자의 제한을 설정하는데 활용합니다.

---

## [Example-1: Use of read command without variable(변수 없이 read 명령 사용)](./input1.sh)
`read` 명령은 변수 없이 사용할 수 있습니다. <br/>
`$REPLY` 변수는 변수 없이 읽기 명령으로 사용자로부터 받은 입력을 읽는 데 사용됩니다.<br/>
변수 없이 `read` 명령을 사용하는 방법을 알기 위해 다음 스크립트로 bash 파일을 만듭니다.

```sh
#!/bin/bash

echo 'What is your favorite programming language?'

# Take input without defining variable
read

# Print the input value
echo "Your answer is $REPLY"
```

## [Example-2: Using simple read command(간단한 read 명령 사용)](./input2.sh)
변수와 함께 `read` 명령을 사용하는 방법을 알기 위해 다음 스크립트로 bash 파일을 만듭니다.<br/>
스크립트를 실행한 후 프로그램은 사용자 입력을 기다립니다. 사용자가 데이터를 입력하고 Enter 키를 누르면 데이터가 답변 변수에 저장됩니다. 응답 변수의 값은 나중에 인쇄됩니다.

```sh
#!/bin/bash

echo -n 'What is your favorite food: '

# Assign input value into a variable
read answer

# Print the value of the variable
echo "Oh! you like $answer!"
```

## [Example-3: Using read command with options(옵션과 함께 read 명령 사용)](./input3.sh)
다음 스크립트로 bash 파일을 생성하여 bash 스크립트에서 –p 및 –s 옵션을 함께 사용하는 방법을 알아보세요.<br/>
이 예에서는 사용자 이름과 비밀번호를 사용자로부터 가져와 특정 값과 비교하여 사용자 이름과 비밀번호가 유효한지 여부를 확인합니다.

```sh
#!/bin/bash

# Type your Login Information
read -p 'Username: ' user
read -sp 'Password: ' pass

# Check the username and password are valid or not
if [[ $user == 'admin' && $pass == '12345' ]]
then
    echo -e '\nSuccessful login'
else
    echo -e '\nUnsuccessful login'
fi
```

## [Example-4: Using read command to take multiple inputs(read 명령을 사용하여 여러 입력 받기)](./input4.sh)
여러 변수 이름과 함께 `read` 명령을 사용하여 한 번에 여러 입력을 가져올 수 있습니다.<br/>
다음 예에서는 읽기 명령을 사용하여 4개의 변수에서 4개의 입력을 가져옵니다.

```sh
#!/bin/bash

# Taking multiple inputs
echo 'type four names of your favorite programming languages'
read lan1 lan2 lan3 lan4
echo "$lan1 is your first choice"
echo "$lan2 is your second choice"
echo "$lan3 is your third choice"
echo "$lan4 is your fourth choice"
```

## [Example-5: Using read command with the time limit(시간제한이 있는 read 명령 사용)](./input5.sh)
다음 스크립트로 bash 파일을 만들어 사용자로부터 시간 제한 입력을 받습니다.<br/>
여기서 시간은 초 단위로 계산됩니다. 다음 예제에서 프로그램은 5초 동안 사용자의 입력을 기다리고 사용자가 5초 이내에 데이터를 입력할 수 없으면 프로그램은 값 없이 종료됩니다.

```sh
#!/bin/bash

# Take input with time limit
read -t 5 -p 'Type your favorite color: ' color

# Print the input value
echo "Your favorite color is $color"
```

## [Example-6: Use of read command with -n option(-n 옵션과 함께 읽기 명령 사용)](./input6.sh)
다음 스크립트로 bash 파일을 생성하여 특정 길이를 입력합니다.<br/>
스크립트에 따르면 사용자는 최대 15자를 입력할 수 있습니다.

```sh
#!/bin/bash

echo 'Enter your phone number(Maximum 15 characters): '

# Take input of a maximum 15 characters long
read -n 15 phone

# Add a newline
echo

# Print the input value
echo "Your phone number is $phone"
```

- 입력중에 15자가 입력되면 자동으로 다음 스텝 진행

## [Example-7: Checking a taken path is file or directory(파일이나 디렉토리 경로를 받아서 확인)](./input7.sh)
다음 스크립트로 bash 파일을 생성하여 터미널에서 경로 값을 입력하고 입력 경로가 디렉토리 또는 파일인지 확인합니다.

```sh
#!/bin/bash

# Take the path value from the input
read -p 'Enter the valid path: ' path

# Check the input values is a directory or not
if [ -d $path ] then
    echo "$path is a directory"
# Check the input values is a file or not
else [ -f $path ] then
    echo "$path is a file"
else
    echo "Invalid path."
fi
```

## [Example-8: Initialize array using the read command(read 명령을 사용하여 배열 초기화)](./input8.sh)
배열 변수는 `read` 명령을 사용하여 선언하고 초기화할 수 있습니다.<br/> 
`read` 명령을 사용하여 배열을 만들고 초기화하는 방법을 알기 위해 다음 스크립트로 bash 파일을 만듭니다. 다음으로 배열의 모든 요소, 배열의 첫 번째 요소, 처음 두 요소 및 배열의 ​​마지막 요소가 인쇄됩니다.

```sh
#!/bin/bash

echo 'Enter five numeric values for the array with space: '

# Read values for the array
read -a MyArr

# Print all array values
echo ${MyArr[@]}

# Print the first value of array
echo ${MyArr[0]}

# Print the first two values of the array
echo ${MyArr[@]:0:2}

# Print the last vale of the array
echo ${MyArr[4]}
```


