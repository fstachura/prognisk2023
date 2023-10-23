#!/bin/sh

dirname=`dirname $1`
filename=`basename $1`
filename_without_extension="${filename%%.*}"
extension="${filename##*.}"

if [[ $extension == "asm" ]]; then
    file=$dirname/$filename_without_extension
else
    file=$1
fi

nasm -w+all -felf64 $file.asm -o $file.o
ld $file.o -o $file
ld -m elf_x86_64 $file.o -o $file
