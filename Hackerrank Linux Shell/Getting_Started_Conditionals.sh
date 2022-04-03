<<'COMMENT'
Read in one character from STDIN.
If the character is 'Y' or 'y' display "YES".
If the character is 'N' or 'n' display "NO".
No other character will be provided as input.

Input Format

One character

Constraints

The character will be from the set .

Output Format

echo YES or NO to STDOUT.

Sample Input

y  
Sample Output

YES
COMMENT

#!/bin/bash

read x
if [[ $x == y || $x == Y ]]
then
    echo "YES"
elif [[ $x == n || $x == N ]]
then
    echo "NO"
fi
