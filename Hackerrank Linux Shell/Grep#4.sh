<<'COMMENT'
Current Task
Given a text file, which will be piped to your command through STDIN, 
use grep to display all those lines which contain any of the following words in them:
the
that
then
those
The search should not be sensitive to case. Display only those lines of an input file, which contain the required words.

Input Format
A text file with multiple lines will be piped to your command through STDIN.

Output Format
Display the required lines without any changes to their relative ordering.
COMMENT

#!/bin/bash

grep -iwE 'th(e|at|en|ose)'