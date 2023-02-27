#!/bin/bash

read -p 'Enter the Recipient: ' RECIPIENT
read -p 'Enter the Subject: ' SUBJECT
read -p 'Enter the Message: ' MESSAGE

`mail -s ${SUBJECT} ${RECIPIENT} <<< ${MESSAGE}`