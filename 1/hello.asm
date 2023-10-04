section .text

global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, text
    mov rdx, length
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

section .data
    text db "Czesc", 0ah
    length equ $ - text

