#!/bin/sh

nasm -felf32 $1.asm -o $1.o
gcc -m32 -no-pie -o $1-c.o -c $1.c
gcc -m32 -no-pie $1-c.o $1.o -o $1
