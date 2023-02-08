#!/bin/bash

#making the directories
for i in {1..5}; do
        for j in {1..2}; do
          mkdir "task0$i"
          mkdir "task0$i"/"0$j"
          touch "task0$i"/"0$j"/test.txt   
          date > "task0$i"/"0$j"/test.txt 
        done
done

#merge

for i in {1..5}; do
      for j in {1..2}; do
          cat "task0$i"/"0$j"/test.txt >> merged.txt
       done
done
