# Command Line Arguments

대부분의 경우 bash 스크립트에는 스크립트에 입력 옵션을 제공하기 위해 인수 값이 필요합니다. 

두 가지 방법으로 bash 스크립트에서 명령줄 인수를 처리할 수 있습니다.

하나는 `argument variables`를 사용하는 것이고 다른 하나는 `getopts` 함수를 사용하는 것입니다. 

명령줄 인수를 처리하는 방법은 아래에 있습니다.

## Using argument variables(인수 변수 사용)
인수 변수는 `$0`부터 시작합니다.

기본 스크립트 파일 이름은 명령줄 인수에서 인수 값을 받는 `$0`에 저장됩니다.

두 개의 인수가 명령줄에 전달되면 인수 값이 `$1` 및 `$2` 변수에 순차적으로 전달됩니다.

## Example -1: Sending three numeric values in the command line arguments(명령줄 인수에서 세 개의 숫자 값 보내기)
다음 스크립트를 사용하여 bash 파일을 만듭니다. 

스크립트는 세 개의 인수 값을 받아 `$1`, `$2` 및 `$3` 변수에 저장합니다. 

루프를 사용하지 않는 방법과 루프를 사용하는 방식으로 총 인수 수와 인쇄 인수 값을 계산합니다. 모든 인수 값의 합계는 나중에 인쇄됩니다.

```sh
#!/bin/bash
# Counting total number of arguments
echo "Total number of arguments: $#"

# Reading argument values individiually
echo "First argument value : $1"
echo "Second argument value : $2"
echo "Third argument value : $3"

# Reading argument values using loop
for argval in "$@"
do
    echo -n "$argval"
done

# Adding argument values
sum=$(($1+$2+$3))

# Print the result
echo -e "\nResult of sum = $sum"
```

**결과**
```sh
./cmdline1.sh 1 2 3

Total number of arguments: 3
First argument value : 1
Second argument value : 2
Third argument value : 3
123
Result of sum = 6
```

### 참고
- [Example1](./cmdline1.sh)

## Example -2: Taking filename as an argument(파일 이름을 인수로 사용)
다음 스크립트로 bash 파일을 만들어 파일의 총 문자 수를 계산합니다. 여기서 파일 이름은 명령줄 인수로 전달됩니다.

```sh
#!/bin/bash
filename=$1
totalchar=`wc -c $filename`
echo "Total numer of characters are $totalchar"
```

**결과**
```sh
./cmdline2.sh cmdline2.sh

Total numer of characters are       99 cmdline2.sh
```

### 참고
- [Example2](./cmdline2.sh)

## Using getopts function(getopts 기능 사용)
데이터베이스 또는 파일에 데이터를 저장하거나 명령줄 인수 값을 기반으로 특정 형식으로 보고서를 생성하려는 경우 `getopts` 함수가 작업을 수행하는 가장 좋은 옵션입니다. 내장 Linux 기능입니다. 따라서 스크립트에서 이 함수를 쉽게 사용하여 명령줄에서 형식이 지정된 데이터를 읽을 수 있습니다.

## Example -3: Reading arguments by getopts function(getopts 함수로 인수 읽기)
`getopts` 함수의 사용을 이해하기 위해 다음 스크립트로 bash 파일을 만듭니다. 

`getopts` 함수는 명령줄 인수 옵션 및 인수 값을 읽기 위해 `while` 루프와 함께 사용됩니다. 여기서는 `i`, `n`, `m`, `e`의 4가지 옵션이 사용됩니다. `case` 문은 특정 옵션을 일치시키고 인수 값을 변수에 저장하는 데 사용됩니다. 마지막으로 변수 값을 인쇄합니다.

```sh
#!/bin/bash

while getopts ":i:n:m:e" arg; do
    case $arg in
        i) ID=$OPTARG;;
        n) Name=$OPTARG;;
        m) Manufacturing_date=$OPTARG;;
        e) Expire_date=$OPTARG;;
    esac
done

echo -e "\n$ID $Name $Manufacturing_date $Expire_date\n"
```

****
```sh
./cmdline3.sh -i p001 -n 'Hot Cake' -m '01-16-2023' -e '06-01-2023'

p001 Hot Cake 01-16-2023
```
- 스크립트에서 간단한 값을 보내야 하는 경우 인수 변수를 사용하는 것이 좋습니다. 그러나 형식화된 방식으로 데이터를 보내려면 `getopts` 함수를 사용하여 인수 값을 검색하는 것이 좋습니다.


### 참고
- [Example3](./cmdline3.sh)

## Example-4: Reading normal arguments and arguments with getopts options(getopts 옵션을 사용하여 일반 인수 및 인수 읽기)
인수 변수와 `getopts` 옵션을 사용하여 명령줄 인수를 읽는 방법은 이 자습서의 이전 예제에서 별도로 표시되었습니다. 그러나 이 두 가지 방법을 단일 스크립트에서 사용하여 명령줄 인수 값을 읽을 수 있습니다. 다음 코드로 bash 스크립트를 생성하여 `getopts` 옵션 및 인수 매개변수에 의해 전달된 명령줄 인수 값을 읽습니다. 

여기서 세 가지 `getopts` 옵션을 사용하여 명령줄의 호스트 이름, 사용자 이름 및 암호를 읽었습니다. 

다음으로 `shift` 명령을 사용하여 인수 변수를 사용하여 명령줄 값을 읽기 위한 명령에서 모든 `getopts` 옵션을 제거했습니다. 이 스크립트는 인수 변수의 최대 세 값을 읽고 인쇄합니다. 코드를 실행한 후 옵션이 없는 인수 값이 제공되지 않으면 메시지가 인쇄됩니다. 그렇지 않으면 인수 변수의 값이 인쇄됩니다.

```sh
#!/bin/bash

# Reading arguments with getopts options
while getopts 'h:u:p' OPTION; do
    case "$OPTION" in
        h)
            # Print hostname
            echo "The host name is $OPTARG" ;;
        u)
            # Print username
            echo "The username is $OPTARG" ;;
        p)
            # Print password
            echo "The password is $OPTARG" ;;
        *)
            # Print helping message for providing wrong options
            echo "Usage: $0 [-h value] [-u value] [-p value]" >&2
            # Terminate from the script
            exit 1 ;;
    esac
done

# Remove all options passed by getopts options
shift "$(($OPTIND -1))"

# Reading first normal arguments
if [ ! -z $1 ]; then
    echo "The first table name is $1"
else
    echo "No normal argument is given."
    exit 1
fi

# Reading second normal arguments
if [ ! -z $2 ]; then
    echo "The second table name is $2"
fi

# Reading third normal arguments
if [ ! -z $3 ]; then
    echo "The third table name is $3"
fi
```

**결과**
```sh
./cmdline4.sh -a

./cmdline4.sh: illegal option -- a
Usage: ./cmdline4.sh [-h value] [-u value] [-p value]

---

./cmdline4.sh -h localhost -u albert -p 123
The host name is localhost
The username is albert
The password is
The first table name is 123

---

./cmdline4.sh -h localhost -u albert -p 123 customer employee
The host name is localhost
The username is albert
The password is
The first table name is 123
The second table name is customer
The third table name is employee
```

### 참고
- [Example4](./cmdline4.sh)

## 명령줄 인수 읽기에 `$@` 사용:
명령줄 인수는 인수 변수 또는 `getopts` 옵션을 사용하지 않고 읽을 수 있습니다. 

첫 번째 대괄호와 함께 `$@`를 사용하는 것은 모든 명령줄 인수 값을 읽는 또 다른 방법입니다.

## Example-5: Reading command line argument values without variable(변수 없이 명령줄 인수 값 읽기)
다음 스크립트로 bash 파일을 만들어 인수 변수 없이 인수 값을 읽고 세 개의 명령줄 인수 값의 합계를 계산합니다. 

``$@`는 여기에서 모든 인수 값을 배열로 읽기 위해 첫 번째 대괄호와 함께 사용되었습니다. 다음으로 처음 세 배열 값의 합계가 인쇄됩니다.

```sh
#!/bin/bash

# Reading all arguments values
argvals=("$@")

# Check the total number of arguments
if [ $# -gt 2 ]
then
    # Calculate the sum of three command line arguments
    sum=$((${argvals[0]}+${aragvals[1]}+${argvals[2]}))
    echo "The sum of 3 command line arguments is $sum"
fi
```

**결과**
```sh
./cmdline5.sh 12 20 90

The sum of 3 command line arguments is 102
```

### 참고
- [Example5](./cmdline5.sh)

