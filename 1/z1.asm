section .text
global _start

_start:
    ; print welcome text
    mov rax, 1
    mov rdi, 1
    mov rsi, welcome_text
    mov rdx, welcome_text_len
    syscall

    ; read name
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 255
    syscall

    ; rax contains number of characters read
    ; input_buffer is directly after response_text
    ; address of response_text + response_text_len + number of bytes read
    ; is address of the last read character (usually newline)
    ; replacing last two chars with exclamation mark and newline
    add rax, response_text_len
    mov byte [response_text + rax - 1], '!'
    mov byte [response_text + rax], 0ah
    add rax, 1
    ; save length response_text + input to input_length
    mov [input_length], rax

    # write response_text + modified input buffer
    mov rax, 1
    mov rdi, 1
    mov rsi, response_text
    mov rdx, [input_length]
    syscall

    ; exit
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

