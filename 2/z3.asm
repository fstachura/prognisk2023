section .text
global _start

%include "common.asm"

_start: 
    mov rsi, number
    mov rdx, number_len
    call read_input 

    mov rbx, numbr
    mov rcx, rax
    sub rax, 1
    call convert_to_int
section .data
    number times 22 db 'x'
    number_len equ $ - number
