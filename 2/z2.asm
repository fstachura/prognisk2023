section .text
global _start

%include "common.asm"

_start:
    mov rsi, number_buf
    mov rdx, number_buf_len
    call read_input

    mov rbx, number_buf
    mov rcx, rax
    dec rcx
    call convert_to_int
    mov rax, r9

    inc rax

    mov rbx, number
    mov rcx, number_len
    call int_to_str

    mov rdx, rax
    inc rdx
    mov rsi, number
    add rsi, number_len
    sub rsi, rax
    call write_output
    
    call exit

section .data
    number times 20 db 'x'
    number_len equ $ - number
    newline db 0ah
    number_buf times 22 db 'x'
    number_buf_len equ $ - number_buf
