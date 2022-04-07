<<'COMMENT'
Given two integers,  and , find their sum, difference, product, and quotient.

Input Format

Two lines containing one integer each ( and , respectively).

Output Format

Four lines containing the sum (), difference (), product (), and quotient (), respectively.
(While computing the quotient, print only the integer part.)

Sample Input

5
2
Sample Output

7
3
10
2
Explanation

5 + 2 = 7
5 - 2 = 3
5 * 2 = 10
5 / 2 = 2 (Integer part)
COMMENT

#!/bin/bash

read X
read Y
echo `expr $X + $Y`
echo `expr $X - $Y`
echo `expr $X \* $Y`
echo `expr $X / $Y`
