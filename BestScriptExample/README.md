# [30 Bash Script Examples](https://linuxhint.com/30_bash_script_examples/#t1)

- [첫 번째 BASH 프로그램 생성 및 실행](#첫-번째-bash-프로그램-생성-및-실행)
- [echo 명령](#echo-명령-사용)
- [주석](#주석-사용)
- [여러 줄 주석](#여러-줄-주석-사용)
- [While Loop](#while-루프-사용)
- [For Loop](#for-loop-사용)
- [Get User Input(사용자 입력 받기)](#get-user-input사용자-입력-받기)

---

# 첫 번째 BASH 프로그램 생성 및 실행
> 터미널에서 또는 bash 파일을 실행하여 bash 스크립트를 실행할 수 있습니다.

터미널에서 다음 명령을 실행하여 매우 간단한 bash 문을 실행합니다. 명령의 출력은 'Hello World'입니다.

```sh
echo "Hello World"

# 출력
Hello World
```

두 가지 방법으로 bash 파일을 실행할 수 있습니다. 
- 하나는 bash 명령을 사용하는 것
- 다른 하나는 bash 파일에 실행 권한을 설정하고 파일을 실행하는 것입니다. 

여기에는 두 가지 방법이 모두 나와 있습니다.

```sh
$ bash First.sh
```

# echo 명령 사용
다양한 옵션과 함께 echo 명령을 사용할 수 있습니다. 몇 가지 유용한 옵션이 다음 예제에 언급되어 있습니다. 옵션 없이 `echo` 명령을 사용하면 기본적으로 새 줄이 추가됩니다. `-n` 옵션은 새 줄 없이 텍스트를 인쇄하는 데 사용되며 `-e` 옵션은 출력에서 ​​백슬래시 문자를 제거하는 데 사용됩니다. 이름이 `echo_example.sh`인 새 bash 파일을 만들고 다음 스크립트를 추가합니다.

```sh
#!/bin/bash
echo "Printing text with newline"
echo -n "Printing text without newline"
echo -e "\nRemoving \t backslash \t characters\n"
```

# 주석 사용
> `#` 기호는 `bash` 스크립트에서 한 줄 주석을 추가하는 데 사용됩니다.

`comment_example.sh`라는 새 파일을 만들고 한 줄 주석으로 다음 스크립트를 추가합니다.

```sh
#!/bin/bash

# Add two numeric value
((sum=25+35))

#Print the result
echo $sum
```

# 여러 줄 주석 사용
`bash`에서 여러 줄 주석을 다양한 방법으로 사용할 수 있습니다.

간단한 방법은 다음 예제에 나와 있습니다. 

`multiline-comment.sh`라는 새 bash를 만들고 다음 스크립트를 추가합니다. 

여기서 `:` 및 ` ' ` 기호는 bash 스크립트에서 여러 줄 주석을 추가하는 데 사용됩니다. 

다음 스크립트는 5의 제곱을 계산합니다.

```sh
#!/bin/bash
: '
The following script calculates
the square value of the number, 5.
'
((area=5*5))
echo $area
```

# While 루프 사용
`while` 루프의 사용법을 알기 위해 `while_example.sh`라는 이름의 `bash` 파일을 만듭니다. 

예제에서 `while` 루프는 5번 반복됩니다. 카운트 변수의 값은 각 단계에서 1씩 증가합니다. `count` 변수의 값이 5가 되면 `while` 루프가 종료됩니다.

```sh
#!/bin/bash
valid=true
```

### 참고
- [while loop example](./while-loop)

# For Loop 사용
`for_example.sh` 스크립트 파일 생성
아래 예제의 for loop는 10번 반복하고 변수 counter의 모든 값을 한 줄에 인쇄합니다.
```sh
#!/bin/bash
for (( counter=10; counter>0; counter-- ))
do
    echo -n "$counter "
done
printf "\n"
```

출력
```sh
./for_example.sh
> 10 9 8 7 6 5 4 3 2 1
```

### 참고
- [for loop example](./for-loop)
- [다양한 for loop 사용법](https://linuxhint.com/bash-for-loop-examples/)


# Get User Input(사용자 입력 받기)
`read` 명령은 bash에서 사용자로부터 입력을 받는 데 사용됩니다.

하나의 문자열 값을 사용자로부터 가져와 다른 문자열 값을 조합하여 표시합니다.

```sh
#!/bin/bash
echo "Enter Your Name"
read name
echo "Welcome $name to LinuxHint"
```

### 참고
- [Bash Script User Input](https://linuxhint.com/bash-script-user-input/)
- [Example](./user-input)


# Using if statement (if 문 사용)
단일 또는 여러 조건과 함께 `if` 조건을 사용할 수 있습니다.

`if` 문의 시작 블록과 끝 블록은 `if`와 `fi`로 정의됩니다.

bash에서 use if 문을 알기 위해 다음 스크립트로 `simple_if.sh`라는 파일을 만듭니다.

여기서 10은 변수 n에 할당되고 `$n`의 값이 10보다 작으면 **한 자리 숫자입니다**가 출력되고, 그렇지 않으면 **두 자리 숫자입니다**가 출력됩니다.<br/>
비교를 위해 여기서는 `-lt`를 사용합니다.<br/>
다른 비교 키워드는 `-eq`는 같음, `-ne`은 같지 않음, `-gt`는 bash 스크립트보다 큼을 의미합니다.

```sh
#!/bin/bash
n=10
if [ $n -lt 10 ]
then
    echo "It is a one digit number"
else
    echo "It is a two digit number"
fi
```

### 참고
- [Using if statement](https://linuxhint.com/30_bash_script_examples/#t8)
- [Example](./if-statement/simple_if.sh)


# Using if statement with AND logic(AND 논리와 함께 if 문 사용)

두 개 이상의 조건이 있는 `if` 문에서 서로 다른 유형의 논리 조건을 사용할 수 있습니다. 

`AND` 논리를 사용하여 `if` 문에서 여러 조건을 정의하는 방법은 다음 예에 나와 있습니다. `&&`는 `if` 문의 `AND` 논리를 적용하는 데 사용됩니다. 

다음 코드를 확인하기 위해 `if_with_AND.sh`라는 파일을 생성합니다. 

여기에서 사용자 이름 및 비밀번호 변수의 값은 사용자로부터 가져와 `admin` 및 `secret`과 비교됩니다. 두 값이 모두 일치하면 **유효한 사용자**가 출력되고 그렇지 않으면 **잘못된 사용자**가 출력됩니다.

### 참고
- [Using if statement with AND logic](https://linuxhint.com/30_bash_script_examples/#t9)
- [Example](./if-statement/if_with_AND.sh)


# Using if statement with OR logic (OR 논리와 함께 if 문 사용)
`||`는 `if` 조건에서 `OR` 논리를 정의하는 데 사용됩니다.<br/>
`if` 문의 `OR` 논리 사용을 확인하기 위해 다음 코드로 `if_with_OR.sh`라는 파일을 생성합니다.<br/>
여기서 n의 값은 사용자로부터 가져옵니다. 값이 15 또는 45이면 출력은 **You win the game**이고, 그렇지 않으면 출력은 **You lost the game**입니다.

```sh
#!/bin/bash

echo 'Enter any number'
read n

if [[ $n -eq 15 || $n -eq 45 ]]
then
    echo 'You won the game'
else
    echo 'You loas the game'
fi
```

### 참고
- [Using if statement with OR logic](https://linuxhint.com/30_bash_script_examples/#t10)
- [Example](./if-statement/if_with_OR.sh)


# Using else if statement (else if 문 사용)
`else if` 조건의 사용은 bash에서 다른 프로그래밍 언어와 약간 다릅니다.<br/>
`elif`는 bash에서 `else if` 조건을 정의하는 데 사용됩니다. `elseif_example.sh`라는 파일을 만들고 다음 스크립트를 추가하여 bash 스크립트에 `else if`가 어떻게 정의되어 있는지 확인합니다.

```sh
#!/bin/bash

echo 'Enter your lucky number'
read n

if [ $n -eq 101 ]
then
    echo 'You got 1st prize'
elif [ $n -eq 510 ]
then
    echo 'You got 2nd prize'
elif [ $n -eq 999 ]
then
    echo 'You got 3rd prize'
else
    echo 'Sorry, try for the next time'
fi
```

### 참고
- [Using else if statement](https://linuxhint.com/30_bash_script_examples/#t11)
- [Example](./if-statement/elseif_example.sh)


# Using Case Statement (case 문 사용)
`if-elseif-else` 문의 대안으로 `case` 문을 사용합니다. 이 문의 시작 블록과 끝 블록은 `case`와 `esac`으로 정의됩니다.

```sh
#!/bin/bash

echo 'Enter your lucky number'
read n

case $n in
    101)
        echo echo 'You got 1st prize' ;;
    510)
        echo 'You got 2nd prize' ;;
    999)
        echo 'You got 3rd prize' ;;
    *)
        echo 'Sorry, try for the next time' ;;
esac
```

### 참고
- [Using Case Statement](https://linuxhint.com/30_bash_script_examples/#t12)
- [Example](./case-statement/case_example.sh)


# Get Arguments from Command Line (커맨드라인에서 인수 가져오기)
Bash 스크립트는 다른 프로그래밍 언어와 마찬가지로 명령줄 인수에서 입력을 읽을 수 있습니다.

`$1` 및 `$2` 변수는 첫 번째 및 두 번째 명령줄 인수를 읽는 데 사용됩니다.

`command_line.sh`라는 파일을 만들고 다음 스크립트를 추가합니다. 다음 스크립트에서 두 개의 인수 값을 읽고 총 인수 수와 인수 값을 출력으로 인쇄합니다.

```sh
#!/bin/bash
echo "Total arguments : $#"
echo "1st Argument : $1"
echo "2nd Argument : $2"
```

### 참고
- [Get Arguments from Command Line](https://linuxhint.com/30_bash_script_examples/#t13)
- [Example](./commandline/command_line.sh)
- [Command Line Arguemnts](./commandline)


# Get arguments from command line with names (이름이 있는 커맨드라인에서 인수 가져오기)
이름이 있는 커맨드라인 인수를 읽는 방법은 다음 스크립트에 나와 있습니다.

`command_line_names.sh`라는 파일을 만들고 다음 코드를 추가합니다. 

여기에서 이 스크립트는 두 개의 인수 X와 Y를 읽고 X와 Y의 합계를 인쇄합니다.

```sh
#!/bin/bash

for arg in "$@"
do
    index=$(echo $arg | cut -d = -f 1)
    val=$(echo $arg | cut -d = -f 2)

    case $index in
        X) x=$val ;;
        Y) y=$val ;;
        *)
    esac
done

((result=x+y))
echo "X+Y=$result"
```

### 참고
- [Get arguments from command line with names](https://linuxhint.com/30_bash_script_examples/#t14)
- [Example](./commandline/command_line_names.sh)
- [CommandLine - cut](../QuickReferences/SHELL_COMMAND.md/#cut)


# Combine String variables (문자열 변수 결합)
bash에서 문자열 변수를 쉽게 결합할 수 있습니다. 

`string_combine.sh`라는 파일을 만들고 다음 스크립트를 추가하여 변수를 함께 배치하거나 `+` 연산자를 사용하여 bash에서 문자열 변수를 결합하는 방법을 확인합니다.


```sh
#!/bin/bash

string1='Linux'
string2='Hint'
echo "$string1$string2"
string3=$string1+$string2
string3+=' is a good tutorial blog site'
echo $string3
```

### 참고
- [Combine String variables](https://linuxhint.com/30_bash_script_examples/#t15)
- [Example](./example-string/string_combine.sh)


# Get substring of String (문자열 자르기)
다른 프로그래밍 언어와 마찬가지로 bash에는 문자열 데이터에서 값을 잘라내는 내장 함수가 없습니다. 
그러나 다음 스크립트에 표시된 bash에서 다른 방식으로 하위 문자열 작업을 수행할 수 있습니다. 

스크립트를 테스트하려면 다음 코드를 사용하여 `substring.sh`라는 파일을 만듭니다. 

```sh
#!/bin/bash

Str='Learn Linux from LinuxHint'
SubStr=${Str:6:5}
echo $SubStr
```
- 여기서 값 6은 하위 문자열이 시작되는 시작점을 나타내고 5는 하위 문자열의 길이를 나타냅니다.
- `Str` 의 6번째 글자부터 연속된 5글자를 가져옵니다.

### 참고
- [Get substring of String](https://linuxhint.com/30_bash_script_examples/#t16)
- [Example](./example-string/substring.sh)


# Add 2 numbers into a variable (변수에 숫자 2개 추가)
다양한 방법으로 bash에서 산술 연산을 수행할 수 있습니다. 

이중 괄호를 사용하여 bash에서 두 개의 정수를 추가하는 방법은 다음 스크립트에 나와 있습니다. 

다음 코드를 사용하여 'add_numbers.sh'라는 파일을 만듭니다. 

사용자로부터 두 개의 정수 값을 가져와 더한 결과를 인쇄합니다.

```sh
#!/bin/bash

echo 'Enter first number'
read x
echo 'Enter second number'
read y
(( sum=x+y ))
echo "The result of addition=$sum"
```

## Bash Arithmetic Operation

### [Example – 1: Using `expr` Command](./example-arithmetic/expr.bash)
bash에서 산술 연산을 수행하는 가장 오래된 명령은 `expr`입니다. 

이 명령은 정수 값에만 사용할 수 있으며 출력을 터미널에 직접 인쇄합니다. 수학 연산을 수행하기 위해 `expr` 명령을 사용하려면 각 피연산자에 공백을 사용해야 합니다. 

`expr` 명령의 사용법을 알기 위해 다음 스크립트로 `expr.bash`라는 `bash` 파일을 만듭니다.

```sh
#!/bin/bash

# Works as the string
expr '10 + 30'

# Works as the string
expr 10+30

# Perform the addition
expr 10 + 30

# Find out the remainder value
expr 30 % 9

# Using expr with backtick
myVal1=`expr 30 / 10`
echo $myVal1

# Using expr within command substitute
myVal2=$( expr 30 - 10 )
echo $myVal2
```

**Result**
```sh
bash expr.bash

10 + 30
10+30
40
3
3
20
```
- 출력은 각 숫자 값에 공백이 사용되고 expr 명령에 작은따옴표가 사용되지 않는 경우에만 산술 연산자가 작동했음을 보여줍니다. 
- expr 명령의 출력을 변수에 할당하고 백틱 또는 명령 대체를 사용하여 나중에 변수를 인쇄할 수도 있습니다. 
- 30/10은 백틱을 사용하여 계산하고 30-10은 명령 대체를 사용하여 계산합니다.

### [Example – 2: Using `let` Command](./example-arithmetic/let.bash)
`let`은 bash에서 산술 연산을 수행하는 또 다른 기본 제공 명령입니다. 

`let` 명령은 값을 변수에 저장하지 않고는 터미널에 출력을 출력할 수 없습니다. 그러나 `let` 명령을 사용하여 `expr` 명령의 다른 제한 사항을 제거할 수 있습니다. 

`let` 명령의 사용법을 알기 위해 다음 스크립트로 `let.bash`라는 bash 파일을 만듭니다.


```sh
#!/bin/bash

# Multiplying 9 by 8
let val1=9*8
echo $val1

# Dividing 8 by 3
let "val2 = 8 / 3"
echo $val2

# Subtracting 3 from 9
let val3=9-3
echo $val3

# Applying increment
let val4=7
let val4++
echo $val4

# Using argument value in arithmetic operation
let "val5=50+$1"
echo $val5
```

**Result**
```sh
bash let.bash 50
72
2
6
8
100
```
- 출력은 `let` 명령이 `expr` 명령보다 더 유연함을 보여줍니다. 
- 따옴표를 사용하거나 사용하지 않고 모든 산술 식을 평가할 수 있습니다. 그러나 어떤 수식에서도 공백을 사용할 수 없습니다. 
- 증가 또는 감소 연산자는 `let` 명령에서 사용할 수 있습니다. 
- `let` 명령을 사용하여 인수 값으로 산술 연산을 수행하는 방법은 예제의 마지막 부분에 나와 있습니다.

### [Example – 3: Using Double Brackets](./example-arithmetic/dbl.bash)
명령을 사용하지 않고 모든 산술 연산을 bash에서 수행할 수 있습니다. 

여기서 이중 괄호는 산술 작업을 수행하는 데 사용되며, 이중 괄호를 사용하여 수식을 실행하는 것은 `expr` 또는 `let`과 같은 명령보다 더 유연합니다. 

이중 괄호를 사용하여 산술 연산을 테스트하려면 다음 스크립트로 dbl.bash라는 bash 파일을 만듭니다.

```sh
#!/bin/bash

# Calcualte the mathematical expression
val1=$((10*5+15))
echo $val1

# Using post or pre increment/decrement operator
((val1++))
echo $val1
val2=41
((--val2))
echo $val2

# Using shorthand operator
(( val2 += 60 ))
echo $val2

# Dividing 40 by 6
(( val3 = 40/6 ))
echo $val3
```

**Result**
```sh
bash dbl.bash
65
66
40
100
6
```
- 출력은 이중 괄호가 공백이 있거나 없는 모든 수학적 표현식을 실행할 수 있으며 이중 괄호 표현식에서 증가/감소 및 속기 연산자를 사용할 수도 있음을 보여줍니다.

### [Example – 4: Using ‘bc’ Command for Float or Double Numbers](./example-arithmetic/bc.bash))
bash에서 산술 연산을 수행하는 위의 방법의 주요 제한 사항 중 하나는 `expr` 또는 `let` 또는 `이중 괄호 표현식`이 부동 소수점 또는 이중 숫자를 생성할 수 없다는 것입니다. 

위 예제의 나눗셈 연산 결과는 정수입니다. 이 문제를 해결하기 위해 'bc' 명령을 사용할 수 있으며 Linux 운영 체제의 기본 계산기로 작동합니다. 

산술 연산에서 'bc' 명령의 사용을 알기 위해 다음 스크립트로 bc.bash라는 bash 파일을 만듭니다.

```sh
#!/bin/bash

# Dividing 55 by 3 bc only
echo "55/3" | bc

# Dividing 55 by 3 bc and -l option
echo "55/3" | bc -l

# Dividing 55 by 3 with bc and scale value
echo "scale=2; 55/3" | bc
```

**Result**
```sh
bash bc.bash
18
18.33333333333333333333
18.33
```
- 출력은 나눗셈 식을 실행할 때 간단한 `bc` 명령이 다른 옵션과 마찬가지로 정수 값을 생성함을 보여줍니다. 
- `bc -l` 명령은 나눗셈의 정확한 출력을 생성하며 스케일 값을 사용하여 분수 부분을 제한할 수 있습니다. 
여기서 scale=2가 사용됩니다. 따라서 출력에는 소수점 이하 2자리가 표시됩니다.


### [Example-5: Using the printf Command for Float or Double Number](./example-arithmetic/.prn.bash)
`printf` 명령은 분수 데이터로 작업하는 또 다른 방법입니다. 

이 명령은 산술 연산 후 `bc` 명령보다 더 효율적으로 부동 소수점 값을 생성하는 데 사용할 수 있습니다. 

이 명령은 숫자의 거듭제곱을 계산하는 데에도 사용할 수 있습니다. 

다양한 산술 연산에 대한 `printf` 명령의 사용이 이 예제에 표시되었습니다. 

다음 스크립트로 prn.bash라는 bash 파일을 만들어 두 숫자 나누기의 분수 출력에 대한 `printf` 명령의 사용을 확인합니다.

```sh
#!/bin/bash
# Take the dividend value from the user
read -p "Enter the dividend value: " n1
# Take the divisor value from the user
read -p "Enter the divisor value: " n2

# Find the division using `echo` and `bc`
echo "scale=2; $n1/$n2"|bc

# Find the division using `printf`
printf "%.2f\n" "$((10**2 * $n1/$n2))e-2"
```

**Result**
bash prn.bash
Enter the dividend value: 9
Enter the divisor value: 4
2.25
2.25
```sh
```

다음 출력은 피제수 값이 부동 소수점 숫자인 경우 `bc` 명령으로 생성된 나누기 값은 정확하지만 `printf` 명령에서 오류가 발생했음을 보여줍니다.

```sh
#!/bin/bash

# Take the dividend value from the user
read -p "Enter the dividend value: " n1
# Take the divisor value from the user
read -p "Enter the divisor value: " n2

# Find the division using `printf`, `echo` and `bc`
printf "%.2f\n" `echo $n1/$n2|bc -l`
```

**Result**
```sh
bash prn2.bash
Enter the dividend value: 7.5
Enter the divisor value: 2
3.75
```
- 다음 스크립트를 사용하여 `prn2.bash`라는 bash 파일을 생성하여 피제수 값이 부동 소수점 숫자일 때 올바른 분수 출력을 위한 `printf` 명령의 사용을 알 수 있습니다.

### [Example-6: Using the awk Command for Arithmetic Operation](./example-arithmetic/awk.bash)

`awk` 명령을 사용하는 것은 부동 소수점 숫자에 대한 출력을 적절하게 생성할 수 있는 산술 연산을 수행하는 또 다른 방법입니다. 

형식화 없이 `awk` 명령을 사용하는 산술 연산과 형식화를 이 예제에 표시했습니다. 

다음 스크립트를 사용하여 `awk.bash`라는 bash 파일을 생성하여 산술 연산을 위한 `awk` 명령 사용을 확인합니다.


```sh
#!/bin/bash

# Initialize the dividend value
n1=90
# Initialize the divisor value
n2=43

# Print the output without formating
awk "BEGIN {print $n1/$n2}"

# Print the output with formatting
awk "BEGIN {printf \"%.2f\n\", $n1/$n2}"
```

**Result**
```sh
bash awk.bash
2.09302
2.09
```
- 출력은 `awk` 명령이 적절한 분수 출력을 생성할 수 있음을 보여줍니다.

### [Example-7: Calculate the Percentage of a Value](./example-arithmetic/percentage.bash)
특정 기준의 백분율 값을 계산해야 하는 경우가 있습니다. 

백분율은 bash에서 `printf` 명령과 `echo` 명령을 사용하여 계산할 수 있습니다. 

전체 학생 수와 총 합격 학생 수를 기준으로 시험에서 합격한 학생의 비율을 알아내야 한다고 가정합니다. 

이 문제에 대한 해결책이 이 예제에 나와 있습니다. `printf` 명령을 사용하여 합격한 학생의 백분율 값을 계산하는 다음 스크립트로 bash 파일을 만듭니다.


```sh
#!/bin/bash

# Take the total number of students from the user
read -p 'Total number of students: ' total_std

# Take the total number of passed students from the user
read -p 'Total number of passed students: ' passed_std

# Calculate the percentage of passed students
printf "The percentage of passed students: %.2f%%\n" "$((10**3 * 100 * $passed_std/$total_std))e-3"
```

**Result**
```sh
bash percentage.bash
Total number of students: 10
Total number of passed students: 7
The percentage of passed students: 70.00%
```

### 참고
- [Add 2 numbers into a variable](https://linuxhint.com/30_bash_script_examples/#t17)
- [Bash Arithmetic Operation](https://linuxhint.com/bash_arithmetic_operations/)
- [Example](./example-arithmetic/add_numbers.sh)


# Create a Function (함수 만들기)
간단한 함수를 만들고 함수를 호출하는 방법은 다음 스크립트에 나와 있습니다. 
`function_example.sh`라는 파일을 만들고 다음 코드를 추가합니다. 
bash 스크립트에서 대괄호를 사용하지 않고 이름만으로 함수를 호출할 수 있습니다.

```sh
#!/bin/bash

function F1()
{
    echo 'I like bash programming'
}

F1
```

**Output**
```sh
./function_example.sh
> I like bash programming
```

### 참고
- [Create a Function](https://linuxhint.com/30_bash_script_examples/#t18)
- [Example](./example-function/function_example.sh)

# Use Function Parameters

## Create function with Parameters (매개변수로 함수 만들기)

Bash는 함수 선언 시 함수 매개변수나 인수를 선언할 수 없습니다. 그러나 다른 변수를 사용하여 함수에서 매개변수를 사용할 수 있습니다. 

함수 호출 시 두 개의 값이 전달되면 `$1` 및 `$2` 변수가 값을 읽는 데 사용됩니다. 

`function_parameter.sh`라는 파일을 만들고 다음 코드를 추가합니다. 
여기서 `Rectangle_Area` 함수는 매개변수 값을 기반으로 직사각형의 면적을 계산합니다.

```sh
#!/bin/bash

Rectangle_Area() {
    area=$(($1 * $2))
    echo "Area is : $area"
}

Rectangle_Area 10 20
```

**Output**
```sh
./function_parameter.sh
> Area is : 200
```


### 참고
- [Use Function Parameters](https://linuxhint.com/30_bash_script_examples/#t19)
- [Example](./example-function/function_parameter.sh)


# Pass Return Value from Script(스크립트에서 반환 값 전달)
Bash 함수는 숫자 값과 문자열 값을 모두 전달할 수 있습니다. 

함수에서 문자열 값을 전달하는 방법은 다음 예제에 나와 있습니다. 

`function_return.sh`라는 파일을 만들고 다음 코드를 추가합니다. 

함수 `greeting()`은 문자열 값을 변수 `val`에 반환하며 나중에 다른 문자열과 결합하여 인쇄합니다.

```sh
#!/bin/bash

function greeting() {
    str="Hello, $name"
    echo $str
}

echo 'Enter your name'
read name

val=$(greeting)
echo "Return value of the function is $val"
```

### 출력
```sh
./function_return.sh
Enter your name
albert
Return value of the function is Hello, albert
```

## [How to Return a String from Bash Functions](https://linuxhint.com/return-string-bash-functions/)

### Use of BASH function that returns a value (값을 반환하는 BASH 함수 사용)
Bash 함수는 다른 표준 프로그래밍 언어처럼 값을 반환할 수 없고, 반환 문을 지원하지만 반환 값을 읽는 데는 다른 구문을 사용합니다.  

다양한 방법으로 bash 함수에서 값을 가져올 수 있습니다. 

이 튜토리얼에서는 다양한 유형의 bash 구문을 사용하여 bash 함수에서 호출자에게 문자열 데이터를 전달하는 방법을 배웁니다. 

bash 함수에서 문자열 또는 숫자 값을 반환하는 방법을 이해합니다.

### [Example-1: Using Global Variable](./example-function/func1.sh)
`Bash` 함수는 전역 변수를 사용하여 문자열 값을 반환할 수 있습니다. 

다음 예제에서는 전역 변수인 `retval`이 사용됩니다. 

함수 호출 전후에 이 전역 변수에 문자열 값이 할당되고 출력됩니다. 
전역 변수의 값은 함수를 호출한 후에 변경됩니다. 

이것은 bash 함수에서 문자열 값을 반환하는 방법입니다.
```sh
#!/bin/bash

function f1() {
    retval='I like programming'
}

retval='I hate programming'
echo $retval
f1
echo $retval
```

**Output**
```sh
./func1.sh
I hate programming
I like programming
```

### [Example-2: Using Function Command](./example-function/func2.sh)
`bash` 함수의 반환값을 받아 호출 시 변수에 저장할 수 있습니다.

다음 예제에서는 로컬 변수인 `retval`이 사용되며, `f2` 함수에 의해 반환되는 로컬 변수의 값은 나중에 출력되는 전역 변수인 `getval`에 할당됩니다.

```sh
#!/bin/bash

function f2() {
    local retval='Using BASH function'
    echo "$retval"
}

getval="$(f2)"
echo $getval
```

**Output**
```sh
./func2.sh
Using BASH function
```

### [Example-3: Using Variable](./example-function/func3.sh)
다음 예제에서는 함수의 인자 변수에 따라 함수의 반환값이 설정됩니다. 

여기서는 함수 호출 시 인수 변수 `getval1`을 사용하여 함수 `f3`에 값을 전달하고, 조건문을 확인한 후 반환값을 할당하고 출력합니다.

```sh
#!/bin/bash

function f3() {
    local arg1=$1

    if [[ $arg1 != '' ]]
    then
        retval='BASH function with variable'
    else
        echo 'No Argument'
    fi
}

getval1='Bash Function'
f3 $getval1
echo $retval
getval2=$(f3)
echo $getval2
```

**Output**
```sh
./func3.sh
BASH function with variable
No Argument
```

### [Example-4: Using Return Statement](./example-function/func4.sh)
대부분의 표준 프로그래밍 언어는 반환문을 사용하여 함수에서 값을 반환합니다. 
위의 예에서는 반환문을 사용하지 않고 함수 값을 반환합니다. 

다음 예제에서는 반환문을 사용하여 함수 `f4`에서 숫자 값을 반환합니다.  

여기서 `$?` 는 반환문을 사용하여 함수가 반환한 값 35를 읽는 데 사용됩니다.

```sh
#!/bin/bash

function f4() {
    echo 'Bash Return Statement'
    return 35
}

f4
echo "Return value of the function is $?"
```

**Output**
```sh
./func4.sh
Bash Return Statement
Return value of the function is 35
```

### 참고
- [Pass Return Value from Script](https://linuxhint.com/30_bash_script_examples/#t20)
- [Example](./example-function/function_return.sh)

# Make directory
Bash는 `mkdir` 명령을 사용하여 새 디렉터리를 생성합니다. 

`make_directory.sh`라는 파일을 생성하고 다음 코드를 추가하여 사용자로부터 새 디렉토리 이름을 가져옵니다. 

디렉터리 이름이 현재 위치에 존재하지 않으면 디렉터리를 생성하고, 그렇지 않으면 오류를 표시합니다.

```sh
```

**Output**
```sh
$ ./make_directory.sh
Enter directory name

$ ls
hi                make_directory.sh

# 같은 이름으로 시도
./make_directory.sh
Enter directory name
hi
mkdir: hi: File exists
```

### 참고
- [Make directory](https://linuxhint.com/30_bash_script_examples/#t21)
- [Example](./example-file/make_directory.sh)


# Make directory by checking existence (존재 여부를 확인하여 디렉토리 만들기)
`mkdir` 명령어를 실행하기 전에 현재 위치에 디렉터리가 있는지 확인하려면 다음 코드를 사용할 수 있습니다. 
`-d` 옵션은 특정 디렉터리의 존재 여부를 테스트하는 데 사용됩니다. 

`directory_exist.sh`라는 파일을 생성하고 다음 코드를 추가하여 존재 여부를 확인하여 디렉터리를 생성합니다.


**Output**
```sh
./directory_exist.sh
Enter directory name
albert
Directory created

ls
albert
```

### 참고
- [Make directory by checking existence](https://linuxhint.com/30_bash_script_examples/#t22)
- [Example](./example-file/directory_exist.sh)


# Read a file (파일 읽기)
`loop`를 사용하여 bash에서 파일을 한 줄씩 읽을 수 있습니다. 

`read_file.sh`라는 파일을 만들고 다음 코드를 추가하여 `book.txt`라는 기존 파일을 읽습니다.

```sh
#!/bin/bash

file='book.txt'

while read line 
do
    echo $line
done > $file
```

**Output**
```sh
./read_file.sh
1. play ground
2. kotlin
3. java

cat book.txt
1. play ground
2. kotlin
3. java
```

## How to read file line by line in Bash script

**company.txt** 파일
```
Company.txt
Samsung
Nokia
LG
Symphony
iphone
```

### Example -1: Reading file content from command line
명령줄에서 `cat` 명령 없이 `company.txt` 파일을 한 줄씩 읽으려고 한다고 가정해 보겠습니다. 다음 명령을 실행하여 작업을 수행합니다. `while` loop는 각 단계에서 `company.txt` 파일에서 각 줄을 읽고 나중에 인쇄될 `$line` 변수에 해당 줄의 내용을 저장합니다.

**Output**
```sh
while read line; do echo $line; done < company.txt
Company.txt
Samsung
Nokia
LG
Symphony
```

### [Example -2: Reading file content using script](./example-file/readfile1.sh)
bash 파일을 만들고 다음 코드를 추가하여 특정 파일의 콘텐츠를 읽습니다. 여기서 기존 파일 이름은 `$filename` 변수에 저장되고 `$n` 변수는 해당 파일의 줄 번호 값을 유지하는 데 사용됩니다. 이전 예제와 마찬가지로 줄 번호가 있는 파일을 읽기 위해 `while` 루프가 사용됩니다.

```sh
#!/bin/bash

filename='company.txt'
n=1

while read line
do
    # Reading each line
    echo "line No. $n : $line"
    n=$((n+1))
done < $filename
```

**Output**
```sh
./readfile1.sh
line No. 1 : Company.txt
line No. 2 : Samsung
line No. 3 : Nokia
line No. 4 : LG
line No. 5 : Symphony
```

### [Example -3: Passing filename from the command line and reading the file](./example-file/readfile2.sh)
명령줄 인수에서 파일 이름을 가져옵니다. 

첫 번째 인수 값은 읽을 파일명을 포함하는 변수 `$1`에서 읽습니다. 파일이 현재 위치에 있으면 동안 루프는 이전 예제처럼 파일을 한 줄씩 읽고 파일 내용을 인쇄합니다.

```sh
#!/bin/bash

filename=$1

while read line
do
    echo $line
done < $filename
```

`employee.txt` 파일을 인수 값으로 사용하여 위 스크립트를 실행합니다. 출력에는 여분의 공백을 제거한 `employee.txt` 파일의 내용이 표시됩니다. `cat` 명령을 사용하면 `employee.txt` 파일의 원본 내용을 표시할 수 있습니다.

**Output**
```sh
./readfile2.sh employee.txt
ID NAME Department Post
S001 Tester1 Sales Marketing Officer
S002 Tester2 Sales Marketing Officer
S003 Tester3 HR Manager
S004 Tester4 HR Assistant Manager
 
cat employee.txt 
ID      NAME        Department      Post
S001    Tester1     Sales           Marketing Officer
S002    Tester2     Sales           Marketing Officer
S003    Tester3     HR              Manager
S004    Tester4     HR              Assistant Manager
S005    Tester5     Tech            Programmer%     
```

### [Example – 4: Reading file by omitting backslash escape](./example-file/readfile3.sh)

백슬래시 이스케이프를 생략하여 파일의 각 줄을 읽으려면 `while` 루프에서 읽기 명령과 함께 `-r` 옵션을 사용해야 합니다.

```sh
#!/bin/bash

filename='company2.txt'

while read -r line
do
    echo $line
done < $filename
```

백슬래시가 있는 company2.txt라는 파일을 만들고 다음 명령을 실행하여 스크립트를 실행합니다. 출력에는 백슬래시 없이 파일 내용이 표시됩니다.

**Output**
```sh
\tSamsung
\tNokia
\nLG
Symphony

# -r 옵션 없이 사용
tSamsung
tNokia
nLG
Symphony
```

### 참고
- [Read a file](https://linuxhint.com/30_bash_script_examples/#t23)
- [How to read file line by line in Bash script](https://linuxhint.com/read_file_line_by_line_bash/)
- [Example](./example-file/read_file.sh)


# Delete a File
`rm` 명령은 bash에서 파일을 제거하는 데 사용됩니다. 

다음 코드를 사용하여 사용자로부터 파일 이름을 가져와 제거할 `delete_file.sh`라는 파일을 생성합니다. 
여기서 `-i` 옵션은 파일을 제거하기 전에 사용자의 권한을 얻기 위해 사용됩니다.

```sh
#!/bin/bash

echo 'Enter filename to remove'
read fn
rm -i $fn
```

**Output**
```sh
 ll DeleteTest
total 0
-rw-r--r--  1 ys  staff     0B  2 20 08:29 test.txt

./delete_file.sh
Enter filename to remove
./DeleteTest/test.txt
remove ./DeleteTest/test.txt? y

ll DeleteTest
total 0
```

### 참고
- [Delete a file](https://linuxhint.com/30_bash_script_examples/#t24)
- [Example](./example-file/delete_file.sh)


# 25. Append to file
bash에서 `>>` 연산자를 사용하여 기존 파일에 새 데이터를 추가할 수 있습니다. `append_file.sh`라는 파일을 생성하고 다음 코드를 추가하여 파일 끝에 새로운 콘텐츠를 추가합니다. 

여기서는 스크립트 실행 후 `book.txt` 파일에 'Learning Laravel 5'가 추가됩니다.

```sh
#!/bin/bash

echo 'Before appending the file'
cat book.txt

echo 'Learning Laravel 5'>> book.txt
echo 'After appending the file'
cat book.txt
```

**Output**
```sh
./append_file.sh

Before appending the file
1. play ground
2. kotlin
3. java
After appending the file
1. play ground
2. kotlin
3. java
Learning Laravel 5
```

### 참고
- [Append to file](https://linuxhint.com/30_bash_script_examples/#t25)
- [Example](./example-file/append_file.sh)


# 26. Test if File Exist
`-e` 또는 `-f` 옵션을 사용하여 bash에서 파일 존재 여부를 확인할 수 있습니다. 다음 스크립트에서는 `-f` 옵션을 사용하여 파일 존재 여부를 테스트합니다. 

`file_exist.sh`라는 파일을 생성하고 다음 코드를 추가합니다. 여기서 파일 이름은 명령줄에서 전달됩니다.

```sh
#!/bin/bash

filename=$1
if [[ -f "${filename}" ]]
then
    echo 'File exists'
else
    echo 'File does not exist'
fi
```

**Output**
```sh
 ./file_exist.sh book.txt
File exists
 
 ./file_exist.sh book2.txt
File does not exist
```

### 참고
- [Test if File Exist](https://linuxhint.com/30_bash_script_examples/#t26)
- [Example](./example-file/file_exist.sh)


# 27. Send Email Example
`mail` 또는 `sendmail` 명령을 사용하여 이메일을 보낼 수 있습니다. 이 명령어를 사용하기 전에 필요한 모든 패키지를 설치해야 합니다. 

`mail_example.sh`라는 파일을 생성하고 다음 코드를 추가하여 이메일을 전송합니다.

```sh
#!/bin/bash

read -p 'Enter the Recipient: ' RECIPIENT
read -p 'Enter the Subject: ' SUBJECT
read -p 'Enter the Message: ' MESSAGE

`mail -s ${SUBJECT} ${RECIPIENT} <<< ${MESSAGE}`
```

**Output**

![send a mail](./examples/send_mail.png)

### 참고
- [Send Email Example](https://linuxhint.com/30_bash_script_examples/#t27)
- [Example](./examples/mail_example.sh)


# 28. Get Parse Current Date
`date` 명령을 사용하여 현재 시스템 날짜 및 시간 값을 가져올 수 있습니다. 날짜 및 시간 값의 모든 부분은 `Y`, `m`, `d`, `H`, `M`, `S`를 사용하여 구문 분석할 수 있습니다. 

`date_parse.sh`라는 새 파일을 생성하고 다음 코드를 추가하여 일, 월, 연, 시, 분, 초 값을 구분합니다.

```sh
#!/bin/bash

Year=`date +%Y`
Month=`date +%m`
Day=`date +%d`
Hour=`date +%H`
Minute=`date +%M`
Second=`date +%S`
echo `date`
echo "Current Date is: ${Day}-${Month}-${Year}"
echo "Current Time is: ${Hour}-${Minute}-${Second}"
```

**Output**
```sh
./date_parse.sh
2023년 2월 28일 화요일 10시 08분 39초 KST
Current Date is: 28-02-2023
Current Time is: 10-08-39
```

### 참고
- [Get Parse Current Date](https://linuxhint.com/30_bash_script_examples/#t28)
- [Example](./example-date/date_parse.sh)


# 29. Wait Command
`wait`는 실행 중인 프로세스가 완료될 때까지 기다리는 Linux의 기본 제공 명령입니다. 

`wait` 명령은 특정 프로세스 ID 또는 작업 ID와 함께 사용됩니다. 

`wait` 명령과 함께 프로세스 ID 또는 작업 ID를 지정하지 않으면 현재 모든 하위 프로세스가 완료될 때까지 기다렸다가 종료 상태를 반환합니다. 

`wait_example.sh`라는 파일을 생성하고 다음 스크립트를 추가합니다.

```sh
#!/bin/bash

echo 'Wait command'
process_id=$!
wait $process_id
echo "Exited with status $?"
```

**Output**
```sh
./wait_example.sh
Wait command
Exited with status 0
```

## Wait Command in Linux
`wait`는 실행 중인 프로세스가 완료될 때까지 기다리는 Linux의 기본 제공 명령입니다. 
`wait` 명령은 특정 프로세스 ID 또는 작업 ID와 함께 사용됩니다. 
셸에서 여러 프로세스가 실행 중인 경우 현재 셸은 마지막 명령의 프로세스 ID만 알 수 있습니다. 

이번에 `wait` 명령이 실행되면 마지막 명령에 적용됩니다. `wait` 명령과 함께 프로세스 ID 또는 작업 ID가 지정되지 않으면 현재 모든 하위 프로세스가 완료될 때까지 기다린 후 종료 상태를 반환합니다.

`wait` 명령의 종료 상태 값은 마지막으로 지정한 피연산자가 나타내는 명령에 따라 달라집니다. 프로세스가 비정상적으로 종료되면 종료 상태는 128보다 크며 다른 명령의 종료 상태 값과 달라집니다. 

`wait` 명령이 아무런 인수 없이 호출되고 현재 셸이 알고 있는 모든 프로세스 ID가 종료된 경우 0 값으로 종료됩니다. `wait` 명령이 오류를 감지하면 1에서 126 사이의 값을 반환합니다. 마지막 프로세스 ID를 알 수 없는 경우 `wait` 명령은 127 값으로 종료됩니다. 

Linux에서 `wait` 명령을 사용하는 방법은 이 튜토리얼에 나와 있습니다.

### Example-1: Using wait command for multiple processes (여러 프로세스에 대기 명령 사용)
다음 스크립트를 실행하면 두 개의 프로세스가 백그라운드에서 실행되고 첫 번째 에코 명령의 프로세스 ID가 `$process_id` 변수에 저장됩니다. 

`process_id`와 함께 `wait` 명령이 실행되면 다음 명령은 첫 번째 에코 명령의 작업이 완료될 때까지 대기합니다. 

두 번째 `wait` 명령은 `'$!'`와 함께 사용되며, 이는 마지막으로 실행 중인 프로세스의 프로세스 ID를 나타냅니다. `'$?'`는 대기 명령의 상태 값을 읽는 데 사용됩니다.

```sh
#!/bin/bash

echo 'testing wait command1' &
process_id=$!
echo 'testing wait command2' &
wait $process_id
echo Job 1 exited with status $?
wait $!
echo Job 2 exited with status $?
```

**Output**
```sh
./wait1.sh
testing wait command1
testing wait command2
Job 1 exited with status 0
Job 2 exited with status 0
```

### Example-2: Test wait command after using kill command (종료 명령 사용 후 대기 명령 테스트)
다음 스크립트에서는 프로세스를 종료한 후 `wait` 명령어를 실행합니다. 
`sleep` 명령어는 백그라운드 프로세스로 실행 중이며, 
`kill` 명령어는 실행 중인 프로세스를 종료하는 명령어입니다. 
그 후 종료된 프로세스의 프로세스 ID로 `wait` 명령이 실행됩니다. 

출력에는 종료된 프로세스의 프로세스 ID가 표시됩니다.

```sh
#!/bin/bash

echo 'Testing wait command'
sleep 20 &
pid=$!
kill $pid
wait $pid
echo $pid was terminated.
```

**Output**
```sh
./wait2.sh
Testing wait command
./wait2.sh: line 7:  8106 Terminated: 15          sleep 20
8106 was terminated.
```

### Example-3: Check the exit status value (종료 상태 값 확인)
다음 스크립트에서는 두 개의 인수 값으로 `check()` 함수를 호출합니다. 

튜토리얼 시작 부분에서 대기 명령이 성공적으로 실행되면 종료 값이 0이 되고 대기 명령이 오류를 감지하면 1에서 126 사이의 값을 반환한다고 설명했습니다. 

스크립트를 실행한 후 두 번째 인수 값으로 0을 전달하면 `wait` 명령이 성공적으로 종료되고 0보다 큰 값을 전달하면 실패로 종료됩니다.

```sh
#!/bin/bash

function check()
{
    echo "Sleep for $1 seconds"
    sleep $1
    exit $2
}

check $1 $2 &
b=$!
echo 'Checking the status'
wait $b && echo OK || echo NOT OK
```

**Output**
```sh
./wait3.sh 3 0
Checking the status
Sleep for 3 seconds
OK

./wait3.sh 3 5
Checking the status
Sleep for 3 seconds
NOT OK
```

### 참고
- [Wait Command](https://linuxhint.com/30_bash_script_examples/#t29)
- [Wait Command in Linux](https://linuxhint.com/wait_command_linux/)
- [Example](./example-wait/wait_example.sh)
- [Example - wait1](./example-wait/wait1.sh)
- [Example - wait2](./example-wait/wait2.sh)
- [Example - wait3](./example-wait/wait3.sh)


# 30. Sleep Command
특정 기간 동안 명령 실행을 일시 중지하려면 `sleep` 명령을 사용할 수 있습니다. 초(s), 분(m), 시간(h), 일(d) 단위로 지연 시간을 설정할 수 있습니다. 

`sleep_example.sh`라는 파일을 생성하고 다음 스크립트를 추가합니다. 이 스크립트는 실행 후 5초 동안 대기합니다.

```sh
#!/bin/bash

echo 'Wait for 5 seconds'
sleep 5
echo 'Complete'
```

**Output**
```sh
./sleep_example.sh
Wait for 5 seconds
Complete
```

## Sleep Command in Linux
`sleep` 명령은 스크립트를 실행하는 동안 일정 시간 동안 지연시키는 데 사용됩니다. 코더가 특정 목적을 위해 명령 실행을 일시 중지해야 하는 경우 이 명령은 특정 시간 값과 함께 사용됩니다. 지연 시간은 초(s), 분(m), 시간(h), 일(d) 단위로 설정할 수 있습니다.  

이 튜토리얼은 다양한 bash 스크립트를 사용하여 `sleep` 명령의 사용법을 배우는 데 도움이 됩니다.

**Sleep command syntax:**
```sh
sleep number[suffix]
```
시간 값으로 정수 또는 분수를 사용할 수 있습니다. 이 명령의 접미사 부분은 선택 사항입니다. 접미사를 생략하면 시간 값은 기본적으로 초 단위로 계산됩니다. 접미사 값으로 `s, m, h, d`를 사용할 수 있습니다. 

다음 예는 다양한 접미사를 사용한 `sleep` 명령의 사용법을 보여줍니다.

### Example-1: sleep command without any suffix
다음 스크립트에서 `sleep` 명령은 숫자 값 2와 함께만 사용되며 접미사는 사용되지 않습니다. 

따라서 스크립트를 실행하면 2초 동안 기다린 후 "작업 완료"라는 문자열이 인쇄됩니다.

```sh
#!/bin/bash

echo 'Waiting for 2 seconds...'
sleep 2
echo 'Task Completed'
```

**Output**
```sh
time ./sleep1.sh 
Waiting for 2 seconds...
Task Completed
./sleep1.sh  0.00s user 0.01s system 0% cpu 2.010 total
```

### Example-2: sleep command with a minute suffix
다음 스크립트에서 `m`은 `sleep` 명령의 접미사로 사용됩니다. 

여기서 시간 값은 0.05분입니다. 0.05분을 기다린 후 "작업 완료" 메시지가 인쇄됩니다.

```sh
#!/bin/bash

echo 'Waiting for 0.05 minutes...'
sleep 0.05m
echo 'Task Completed'
```

**Output**
```sh
time ./sleep2.sh 
Waiting for 0.05 minutes...
usage: sleep seconds
Task Completed
./sleep2.sh  0.00s user 0.00s system 69% cpu 0.009 total
```

### Example-3: sleep command with hour suffix
다음 스크립트에서 `h`는 `sleep` 명령의 접미사로 사용됩니다. 

여기서 시간 값은 0.003시간입니다. 0.003시간 대기 후 화면에 "작업 완료"가 출력되어야 하지만 실제로는 `h` 접미사를 사용할 때 더 많은 시간이 필요합니다.

```sh
#!/bin/bash

echo 'Waiting for 0.003 hours...'
sleep 0.003h
echo 'Task Completed'
```

**Output**
```sh
time ./sleep3.sh   
Waiting for 0.003 hours...
usage: sleep seconds
Task Completed
./sleep3.sh  0.00s user 0.00s system 1% cpu 0.361 total
```

### Example-4: sleep command with loop
 `sleep` 명령은 다양한 용도로 사용할 수 있습니다. 
 
 다음 예제에서는 `sleep` 명령어를 `while 루프`와 함께 사용합니다. 처음에는 변수 n의 값이 1로 설정되어 있으며, 2초 간격으로 4회씩 1씩 증가합니다. 
 
 따라서 스크립트를 실행하면 2초를 기다린 후 각 출력이 나타납니다.

```sh
#!/bin/bash

n=1
while [ $n -lt 5 ]
do
    echo "the value of n is now $n"
    sleep 2
    echo ' '
    ((n=$n+1))
done
```

**Output**
```sh
time ./sleep4.sh
the value of n is now 1
 
the value of n is now 2
 
the value of n is now 3
 
the value of n is now 4
 
./sleep4.sh  0.00s user 0.01s system 0% cpu 8.034 total
```

### Example-5: sleep command in the terminal with other commands
여러 명령을 실행하고 두 명령의 출력 사이에 고정된 시간 간격을 설정하려는 경우 슬립 명령을 사용하여 해당 작업을 수행할 수 있습니다. 이 예제에서는 `ls` 명령과 `pwd` 명령이 절전 명령과 함께 사용됩니다. 명령을 실행하면 `ls` 명령은 현재 디렉터리의 디렉터리 목록을 표시하고 2초 동안 기다린 후 현재 작업 디렉터리 경로를 표시합니다.

```sh
ls && sleep 2 && pwd
```

**Output**
```sh
ls && sleep 2 && pwd
sleep1.sh        sleep2.sh        sleep3.sh        sleep4.sh        sleep_example.sh
/Users/ys/Documents/my-shell-history/BestScriptExample/example-sleep
```

### Example-6: Using sleep command from the command prompt
`sleep` 명령은 다음 예제에서 두 개의 에코 명령 사이에 사용됩니다. 명령 실행 후 세 개의 시간 값이 표시됩니다.

```sh
time (echo "Start"; sleep 5; echo "End")
```

**Output**
```sh
time (echo "Start"; sleep 5; echo "End")
Start
End
( echo "Start"; sleep 5; echo "End"; )  0.00s user 0.00s system 0% cpu 5.008 total
```

### 참고
- [Sleep Command](https://linuxhint.com/30_bash_script_examples/#t30)
- [Sleep Command in Linux](https://linuxhint.com/sleep_command_linux/)
- [Example](./example-sleep/sleep_example.sh)
- [sleep1](./example-sleep/sleep1.sh)
- [sleep2](./example-sleep/sleep2.sh)
- [sleep3](./example-sleep/sleep3.sh)
- [sleep4](./example-sleep/sleep4.sh)