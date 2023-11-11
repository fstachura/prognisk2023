#!/bin/sh

nasm -felf $1.asm -o $1.o
gcc -m32 -no-pie $1.o -o $1
