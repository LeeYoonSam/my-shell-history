# While Loop Example

기본 while loop 구문

```sh
while [ condition ]
do
    commands
done
```

- while 루프의 시작 및 종료 블록은 bash 스크립트의 do 및 done 키워드로 정의됩니다. 종료 조건은 루프 시작 시 정의됩니다.

## Example-1: Iterate the loop for a fixed number of times
```sh
#!/bin/bash

# Initialize the counter
n=1
# Iterate the loop for 5 times
while [ $n -le 5 ]
do
    # Print the value of n in each iteration
    echo "Running $n time"
    # Increment the value of n by 1
    (( n++ ))
done
```

## Example-2: Using break statement for conditional exit
```sh
#!/bin/bash

# Initialize the counter
n=1
# Iterate the loop for 10 times
while [ $n -le 10 ]
do
    # Check the value of n
    if [ $n == 6 ]
    then
        echo "terminated"      
        break
    fi
    # Print the current value of n
    echo "Position: $n"
    # Increment the value of n by 1
    (( n++ ))
done
```

## Example-3: Using continue statement to omit particular step
```sh
#!/bin/bash

# Initialize the counter
n=0
# Iterate the loop for 5 times
while [ $n -le 5 ]
do
    # Increment the value of n by 1
    (( n++ ))
   
    # Check the value of n
    if [ $n == 3 ]
    then
        continue
    fi
    # Print the current value of n
    echo "Position: $n"
   
done
```

## Example-4: Read the command-line argument with options
```sh
#!/bin/bash

# Read the command-line arguments values with option using loop
while getopts n:a:e: OPT
do
        case "${OPT}"
        in
           n) name=${OPTARG};;
           a) address=${OPTARG};;
           e) email=${OPTARG};;
           *) echo "Invalid option"
              exit 1;;
        esac
done
# Print the argument values
printf "Name:$name\nAddress:$address\nEmail:$email\n"
```

## Example-5: Read file line by line
```sh
#!/bin/bash

# Check the command-line argument value is given or not
if [ $# -gt 0 ]; then
    # Assign the filename from comand-line argument value
    filename=$1
   
    # Read file line by line
    while read line; do
        # Print each line
        echo $line
    done < $filename
else
    # Print message if no argument is provided
    echo "Argument value is missing."
fi
```

## Example-6: Write content into a file
```sh
#! /bin/bash

echo -n "Enter the filename to create: "
# Take the filename that will be created
read filename
# Read the content of the file from the terminal
while read line
do
    echo $line >> $filename
done
```

## Example-7: Creating an infinite loop
```sh
#!/bin/bash

# Initialize the counter
n=1
# Declare an infinite loop
while :
do
    printf "The current value of n=$n\n"
    if [ $n == 3 ]
    then
        echo "good"
    elif [ $n == 5 ]
    then
        echo "bad"
    elif [ $n == 7 ]
    then
        echo "ugly"
    elif [ $n == 10 ]
    then
        exit 0
    fi  
    # Increment the value of n by 1
    ((n++))

done
# Take the filename that will be created
read filename
# Read the content of the file from the terminal
while read line
do
    echo $line >> $filename
done
```

## Example-8: Using C-style while loop
```sh
#!/bin/bash

# Initialize the counter
n=5
# Define the while in C-style
while((n <= 50))
do
   echo $n
   # Increment counter by 10
   ((n=n+10))
done
```


## 참고
- [BASH while loop examples](https://linuxhint.com/bash-while-loop-examples/)