section .text
global _start

%include "common.asm"

gcd:
    ; rdi - a
    ; rsi - b
    cmp rsi, 0
    je gcd.ret
    
    ; r9 = t = b
    mov r9, rsi
    ; rdx = a % b, rax = a/b
    mov rdx, 0
    mov rax, rdi
    div rsi
    mov rsi, rdx
    
    ; a = t
    mov rdi, r9
    jmp gcd
gcd.ret:
    ; return a
    mov rax, rdi
    ret

read_number:
    mov rsi, number_input
    mov rdx, number_input_len
    call read_input

    ; rbx - text
    ; rcx - text length
    mov rbx, number_input
    mov rcx, rax
    sub rcx, 1                 ; skip newline
    call convert_to_int
    mov rax, r9
    ret

_start:
    call read_number
    mov [n], rax
    call read_number
    mov [a], rax
    call read_number
    mov [b], rax

_start.loop:
    mov rax, [a]
    mov rbx, [b]
    cmp rax, rbx
    jge exit

    mov rdi, [a]
    mov rsi, [n]
    call gcd

    cmp rax, 1
    jne _start.loop_end

    ; rax - number
    ; rbx - result buffer
    ; rcx - buffer length
    mov rax, [a]
    mov rbx, number_input
    mov rcx, number_input_len
    call int_to_str
    ; returns length of the number in rax

    ; rsi - text address
    ; rdx - text length
    mov rdx, rax
    inc rdx             ; newline
    mov rsi, number_input
    add rsi, number_input_len
    ; substract number length to get beginning of the number
    sub rsi, rax
    call write_output

_start.loop_end:
    mov rax, [a]
    inc rax
    mov [a], rax
    jmp _start.loop

section .data
    n dq 0
    a dq 0
    b dq 0
    number_input times 3*21 db 0
    number_input_len equ $ - number_input 
    newline db 0ah

