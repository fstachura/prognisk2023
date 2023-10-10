section .text
global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, x
    mov rdx, 2
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, y
    mov rdx, 2
    syscall

    mov al, [x]
    sub al, '0'
    mov bl, [y]
    sub bl, '0'

    mul bl
    mov cl, 10
    div cl

    add al, '0'
    add ah, '0'
    mov word [x], ax

    mov byte [newline], 0ah

    mov rax, 1
    mov rdi, 1
    mov rsi, x
    mov rdx, 3
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

section .data
    x db 0
    y db 0
    newline db 0ah

