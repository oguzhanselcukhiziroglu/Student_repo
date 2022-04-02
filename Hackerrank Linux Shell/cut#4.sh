<<'COMMENT'
Display the first four characters from each line of text.

Input Format
A text file with lines of ASCII text only.

Output Format
The output should contain N lines. Each line should contain just the first four characters of the corresponding input line.

Sample Input
Hello
World
how are you

Sample Output
Hell
Worl
how
COMMENT

#!/bin/bash
read -p "Please enter your input : " text
cat $text | cut -c -4 