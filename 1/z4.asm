section .text
global _start

_start:
    ; read time (in seconds since 1970)
    mov rax, 201
    mov rdi, 0
    syscall

    ; divide time by 10 to get the least significant digit of seconds
    ; clear edx to avoid errors
    mov edx, 0
    mov edi, 10
    ; EAX = (EDX:EAX div EDI)
    ; EDX = (EDX:EAX mod EDI)
    div edi
    ; convert edx (digit) to ascii
    add edx, '0' 
    ; save to memory
    mov byte [time_data + time_data_len - 2], dl

    mov edx, 0
    mov edi, 6
    div edi
    add edx, '0'
    mov byte [time_data + time_data_len - 3], dl

    mov edx, 0
    mov edi, 10
    div edi
    add edx, '0'
    mov byte [time_data + time_data_len - 5], dl

    mov edx, 0
    mov edi, 6
    div edi
    add edx, '0'
    mov byte [time_data + time_data_len - 6], dl

    ; divide remainder by 24 to get hours
    mov edx, 0
    mov edi, 24
    div edi
    ; eax = div, edx = mod

    ; convert hours (two digit number) to ascii
    mov eax, edx
    mov edx, 0
    mov edi, 10
    div edi

    add edx, '0'
    mov byte [time_data + time_data_len - 8], dl

    add eax, '0'
    mov byte [time_data + time_data_len - 9], al

    ; write text
    mov rax, 1
    mov rdi, 1
    mov rsi, time_text
    mov rdx, time_text_len + time_data_len
    syscall

    ; exit
    mov rax, 60
    mov rdi, 0
    syscall

section .data
    time_text db "Time: "
    time_text_len equ $ - time_text
    time_data db "##:##:##", 0ah
    time_data_len equ $ - time_data

