section .text
global _start

read_input:
    ; rax - length of read text
    mov rax, 0
    mov rdi, 0
    syscall
    ret

exit:
    mov rax, 60
    mov rdi, 0
    syscall

convert_to_int:
    ; r9 - result
    ; rcx - text length
    ; rbx - text
    mov r8, 1
    mov r9, 0
    add rbx, rcx
    dec rbx
convert_to_int.loop:
    mov al, [rbx]
    sub al, '0'

    mov rdx, 0
    mov ah, 0
    mov di, 10
    div di
    ; rax r rdx

    imul rdx, r8
    add r9, rdx
    imul r8, 10 

    sub rbx, 1
    sub rcx, 1
    jnz convert_to_int.loop

    mov rax, r9
    ret

is_prime:
    ; rdi - number
    mov rcx, 2
is_prime.loop:
    mov rdx, 0
    mov rax, rdi
    div rcx
    test rdx, rdx
    jz is_prime.fail

    imul rcx, rcx
    cmp rcx, rdi
    jl is_prime.loop
    mov rax, 0
    jmp is_prime.exit
is_prime.fail:
    mov rax, 1
is_prime.exit:
    ret

_start:
    mov rsi, number_input
    mov rdx, number_input_len
    call read_input

    mov rbx, number_input
    mov rcx, rax
    sub rcx, 1                 ; skip newline
    call convert_to_int

    mov rdi, rax
    call is_prime

    jmp exit

section .data
    number_input times 21 db 0
    number_input_len equ $ - number_input 
