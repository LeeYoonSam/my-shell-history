# For Loop Example

## Example-1: Reading static values
```sh
#!/bin/bash
# Define loop to read string values
for color in Blue Green Pink White Red
do
    # Print the string value
    echo "Color = $color"
done
```

## Example-2: Reading Array Variable
```sh
#!/bin/bash
# Declare and array
ColorList=("Blue Green Pink White Red")
# Define loop to  iterate the array values
for color in $ColorList
do
    # Check the value is pink or not
    if [ $color == 'Pink' ]
    then
        echo "My favorite color is $color"
    fi
done
```

## Example-3: Reading Command-line arguments
```sh
#!/bin/bash
# Define loop to read argument values
for myval in $*
do
    # Print each argument
    echo "Argument: $myval"
done
```

## Example-4: Finding odd and even number using three expressions
```sh
#!/bin/bash

# Define for loop in C-style format
for (( n=1; n<=5; n++ ))
do  
    # Check the number is even or not
    if (( $n%2==0 ))
    then
        echo "$n is even"
    else
        echo "$n is odd"
    fi  
done
```

## Example-5: Reading file content
```sh
#!/bin/bash
# Initialize the counter
i=1
# Define for loop to read the text file
for var in `cat weekday.txt`
do
    # Print the file content
    echo "Weekday $i: $var"
    ((i++))
done
```

## Example-6: Create infinite for loop
```sh
#!/bin/bash
# Initialize counter variable
counter=1
# Display message for termination
echo "Press Ctrl+c to terminate from the loop"
# Define infinite loop
for (( ;; ))
do
   # Print the number of iteration
   echo "Iterating for $counter time(s)."
   # Wait for 1 second
   sleep 1
   # Increment the counter
   ((counter++))
done
```

## Example-7: Use of for loop with command substitute
```sh
#!/bin/bash
echo "All bash files starting with 'a' are:"

# Read the output of command substitute using for loop
for val in $(ls a*.bash)
do
    # Print the file name
    echo "$val"
done
```

## Example-8: Conditional exit with break
```sh
#!/bin/bash
# Define a for loop to iterate 10 times
for (( i=1; i<=10; i++ ))
do  
    # Define the conditions to terminate the loop
    if (( $i%3==0 && $i%6==0 ))
    then
        # Terminate from the loop
        echo "Terminated."
        break
    else
        # Print the current value of i
        echo "The current value of i is: $i"
    fi  
done
```

## Example-9: Early continuation with continue statement
```sh
#!/bin/bash
# Declare an associative array
declare -A Applicants
# Intialize the array values
Applicants=( [1022]="Present" [1034]="Present" [1045]="Absent" [1067]="Present" )

echo "List of the applicant's ID who are present:"
for k in ${!Applicants[@]}
do
     # Filter the applicant's ID who are absent
     if [ ${Applicants[$k]} == "Absent" ]; then
        continue
     else
        # Print the applicant's ID who are present
        echo $k
     fi
done
```


### 참고
- [다양한 for loop 사용법](https://linuxhint.com/bash-for-loop-examples/)