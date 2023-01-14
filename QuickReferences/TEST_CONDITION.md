# Quick Reference
> 이것은 셸 스크립트에서 쉽게 추측할 수 없는 명령과 코드의 의미에 대한 빠른 참조 가이드입니다. 본질적으로 검색 엔진을 사용하여 찾기가 매우 어렵습니다.<br/>
> 이러한 예에는 프로세스 관리, 셸 스크립트 인수 및 셸 스크립트 `test` 조건이 포함됩니다.

Command	Description | Example
--- | ---
& &emsp;&emsp;	Run the previous command in the background	| ls &
&& &emsp;&emsp;	Logical AND	| if [ "$foo" -ge "0" ] && [ "$foo" -le "9"]
\|\| &emsp;&emsp;	Logical OR	| if [ "$foo" -lt "0" ] || [ "$foo" -gt "9" ]
^ &emsp;&emsp;	Start of line	| grep "^foo"
$ &emsp;&emsp;	End of line	| grep "foo$"
= &emsp;&emsp;	String equality (cf. -eq)	| if [ "$foo" = "bar" ]
! &emsp;&emsp;	Logical NOT	| if [ "$foo" != "bar" ]
\$$ &emsp;&emsp;	PID of current shell	| echo "my PID = $$"
$! &emsp;&emsp;	PID of last background command	| ls & echo "PID of ls = $!"
$? &emsp;&emsp;	exit status of last command	| ls ; echo "ls returned code $?"
$0 &emsp;&emsp;	Name of current command (as called)	| echo "I am $0"
$1 &emsp;&emsp;	Name of current command's first parameter	| echo "My first argument is $1"
$9 &emsp;&emsp;	Name of current command's ninth parameter	| echo "My ninth argument is $9"
$@ &emsp;&emsp;	All of current command's parameters (preserving whitespace and quoting)	| echo "My arguments are $@"
$* &emsp;&emsp;	All of current command's parameters (not preserving whitespace and quoting)	| echo "My arguments are $*"
-eq &emsp;&emsp;	Numeric Equality	| `if [ "$foo" -eq "9" ]`
-ne &emsp;&emsp;	Numeric Inquality	| `if [ "$foo" -ne "9" ]`
-lt &emsp;&emsp;	Less Than	| `if [ "$foo" -lt "9" ]`
-le &emsp;&emsp;	Less Than or Equal	| `if [ "$foo" -le "9" ]`
-gt &emsp;&emsp;	Greater Than	| `if [ "$foo" -gt "9" ]`
-ge &emsp;&emsp;	Greater Than or Equal	| `if [ "$foo" -ge "9" ]`
-z &emsp;&emsp;	String is zero length	| `if [ -z "$foo" ]`
-n &emsp;&emsp;	String is not zero length	| `if [ -n "$foo" ]`
-nt &emsp;&emsp;	Newer Than	| `if [ "$file1" -nt "$file2" ]`
-d &emsp;&emsp;	Is a Directory	| `if [ -d /bin ]`
-f &emsp;&emsp;	Is a File	| `if [ -f /bin/ls ]`
-r &emsp;&emsp;	Is a readable file	| `if [ -r /bin/ls ]`
-w &emsp;&emsp;	Is a writable file	| `if [ -w /bin/ls ]`
-x &emsp;&emsp;	Is an executable file	| `if [ -x /bin/ls ]`
( ... ) &emsp;&emsp;	Function definition	| `function myfunc() { echo hello }`