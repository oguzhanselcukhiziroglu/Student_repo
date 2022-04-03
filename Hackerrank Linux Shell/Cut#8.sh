<<"COMMENT"
Given a sentence, identify and display its first three words. 
Assume that the space (' ') is the only delimiter between words.

Input Format
A text file with lines of ASCII text only. Each line has exactly one sentence.

Output Format
The output should contain N lines. 
For each input sentence, identify and display its first three words. 
Assume that the space (' ') is the only delimiter between words.
COMMENT

#!/bin/bash

while read line
do
    echo $line | cut -d " " -f 1-3
done