section .text
global _start

_start:
    mov rax, 2
    mov rdi, filename
    mov rsi, 2000o          ; append
    or rsi, 100o            ; create
    or rsi, 2o              ; write
    mov rdx, 200o           ; user write
    or rdx, 400o            ; user read
    syscall

    mov rdi, rax

    mov rax, 1
    mov rsi, data
    mov rdx, data_len
    syscall

    mov rax, 3
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

section .data
    filename db "file", 0h
    data db "Franciszek Stachura", 0ah
    data_len equ $ - data

