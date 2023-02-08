#!/bin/bash

#removingdirectories


for i in {1..5}; do
        for j in {1..2}; do
          rm "task0$i"/"0$j"/test.txt 
        done
done

