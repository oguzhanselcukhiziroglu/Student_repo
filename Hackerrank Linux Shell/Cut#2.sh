<<'COMMENT'
Display the  and  character from each line of text.
Input Format
A text file with  lines of ASCII text only.

Output Format
The output should contain  lines. Each line should contain just two characters at the  and the  position of the corresponding input line.

Sample Input
Hello
World
how are you

Sample Output
e
o
oe
COMMENT

#!/bin/bash
read -p "Please enter your input : " text
cat $text | cut -c 2,7 
