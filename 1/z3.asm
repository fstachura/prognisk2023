section .text
global _start

_start:
    ; open file
    mov rax, 2
    mov rdi, filename
    mov rsi, 2000o          ; append
    or rsi, 100o            ; create
    or rsi, 2o              ; write
    mov rdx, 200o           ; user write
    or rdx, 400o            ; user read
    syscall

    ; save file descriptor in rax
    mov rdi, rax

    ; write data to file descriptor
    mov rax, 1
    mov rsi, data
    mov rdx, data_len
    syscall

    ; close file
    mov rax, 3
    syscall

    ; exit
    mov rax, 60
    mov rdi, 0
    syscall

section .data
    filename db "file", 0h
    data db "Franciszek Stachura", 0ah
    data_len equ $ - data

