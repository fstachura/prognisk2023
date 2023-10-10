section .text
global _start

_start:
    ; read x (single byte for number + another byte for newline)
    mov rax, 0
    mov rdi, 0
    mov rsi, x
    mov rdx, 2
    syscall

    ; read y (single byte for number + another byte for newline)
    mov rax, 0
    mov rdi, 0
    mov rsi, y
    mov rdx, 2
    syscall

    ; al = int(x)
    mov al, [x]
    sub al, '0'
    ; bl = int(y)
    mov bl, [y]
    sub bl, '0'

    ; multiply
    mul bl
    ; divide by 10 to get first and second digit
    mov cl, 10
    div cl

    ; convert digits back to ascii
    add al, '0'
    add ah, '0'
    ; save them in memory
    mov word [x], ax

    ; repair newline (destroyed by read y)
    mov byte [newline], 0ah

    ; write two digits + newline
    mov rax, 1
    mov rdi, 1
    mov rsi, x
    mov rdx, 3
    syscall

    ; exit
    mov rax, 60
    mov rdi, 0
    syscall

section .data
    x db 0
    y db 0
    newline db 0ah

