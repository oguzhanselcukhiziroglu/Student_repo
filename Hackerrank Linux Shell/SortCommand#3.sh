<<'COMMENT'
In this challenge, we practice using the sort command to sort input in text or TSV formats.
You are given a text file where each line contains a number. 
The numbers may be either an integer or have decimal places. 
There will be no extra characters other than the number or the newline at the end of each line. 
Sort the lines in ascending order - so that the first line holds the numerically smallest number 
and the last line holds the numerically largest number.

Output Format
Output the text file with the lines reordered in numerically ascending order.
COMMENT

#!/bin/bash

sort -n $1