<<'COMMENT'
Write a Bash script which accepts  as input and displays the greeting "Welcome (name)"

Input Format

There is one line of text, .

Output Format

One line: "Welcome (name)" (quotation marks excluded).
The evaluation will be case-sensitive.

Sample Input 0

Dan  
Sample Output 0

Welcome Dan  
Sample Input 1

Prashant
Sample Output 1

Welcome Prashant
COMMENT

#!/bin/bash

read name
echo "Welcome $name"