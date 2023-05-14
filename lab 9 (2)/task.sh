#!/bin/bash

gcc -o task -pthread task.c

threads=$1
{ time ./task $threads; } 2> runtime.txt
rm task
