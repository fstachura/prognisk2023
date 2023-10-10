#!/bin/sh

nasm -felf $1.asm -o $1.o
ld $1.o -o $1
ld -m elf_i386 $1.o -o $1
