#!/bin/bash

while read line
do
    echo "$line" | cut -f 2-
done