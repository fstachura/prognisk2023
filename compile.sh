#!/bin/sh

nasm -w+all -felf64 $1.asm -o $1.o
ld $1.o -o $1
ld -m elf_x86_64 $1.o -o $1
