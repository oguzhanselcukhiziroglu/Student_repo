<<'COMMENT'
Your task is to use for loops to display only odd natural numbers from  to .

Output Format

1
3
5
.
.
.
.
.
99  
COMMENT

#!/bin/bash

for num in {1..99..2}
do 
    echo "$num"
done
