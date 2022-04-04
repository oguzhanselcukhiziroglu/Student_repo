<<"COMMENT"
Task
You are given a text file that will be piped into your command through STDIN. 
Use grep to remove all those lines that contain the word 'that'. 
The search should NOT be sensitive to case.

Input Format
A text file will be piped into your command through STDIN.

Output Format
Only display those lines that do NOT contain the word 'that'. 
The relative ordering of the lines should be the same as it was in the input file.
COMMENT

#!/bin/bash

cat $1 | grep -viw "that"