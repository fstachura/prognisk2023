section .text
global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, welcome_text
    mov rdx, welcome_text_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 255
    syscall

    add rax, response_text_len
    mov byte [response_text + rax - 1], '!'
    mov byte [response_text + rax], 0ah
    add rax, 1
    mov [input_length], rax

    mov rax, 1
    mov rdi, 1
    mov rsi, response_text
    mov rdx, [input_length]
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

section .data
    welcome_text db "Jak masz na imię?", 0ah
    welcome_text_len equ $ - welcome_text 
    response_text db "Witaj "
    response_text_len equ $ - response_text
    input_buffer times 256 db 0
    input_length dq 0

