#!/bin/sh

nasm -felf64 $1.asm -o $1.o
gcc -lm -no-pie -o $1-c.o -c $1.c
gcc -lm -no-pie $1-c.o $1.o -o $1
