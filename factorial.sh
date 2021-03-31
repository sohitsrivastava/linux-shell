#!/bin/bash

# Find a factorial of a number

i="${1}"
f=1
for (( ; i>=1; --i ))
do
f=$(( f*i ))
done
echo "Factorial of a number is: ${f}"
