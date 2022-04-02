<<"COMMENT"
Display a range of characters starting at the  position of a string and ending at the  position (both positions included).

Input Format
A text file containing  lines of ASCII text only.

Output Format
The output should contain  lines.
Each line should contain the range of characters starting at the  position of a string and ending at the  position (both positions included).

Sample Input
Hello
World
how are you

Sample Output
ello
orld
ow are
COMMENT

#!/bin/bash
read -p "Please enter your input : " text
cat $text | cut -c 2-7