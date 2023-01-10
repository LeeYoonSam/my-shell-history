#!/bin/bash

echo 'Input your number: '

read

if [ $REPLY -lt 10 ]
then
    echo "Your number $REPLY is a one digit number."
else
    echo "Your number $REPLY is a two digit number."
fi