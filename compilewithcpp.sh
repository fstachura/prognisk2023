#!/bin/sh

nasm -felf64 $1.asm -o $1.o
g++ -O0 -lm -no-pie -o $1-cpp.o -c $1.cpp
g++ -O0 -lm -no-pie $1-cpp.o $1.o -o $1
