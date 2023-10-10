section .text
global _start

%include "common.asm"

is_prime:
    ; rdi - number
    mov rcx, 2
    mov r9, rdi
    cmp rdi, 2
    je is_prime.success
is_prime.loop:
    mov rdx, 0
    mov rax, rdi
    div rcx
    test rdx, rdx
    jz is_prime.fail

    inc rcx
    mov r8, rcx
    imul r8, r8
    cmp r8, r9  
    jl is_prime.loop
is_prime.success:
    mov rax, 1
    jmp is_prime.exit
is_prime.fail:
    mov rax, 0
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
    
    cmp rax, 0
    je _start.response_no
    mov rsi, response_yes
    mov rdx, response_yes_len
    jmp _start.skip_response_no
_start.response_no:
    mov rsi, response_no
    mov rdx, response_no_len
_start.skip_response_no: 
    call write_output
    jmp exit

section .data
    number_input times 21 db 0
    number_input_len equ $ - number_input 
    response_yes db "Number is prime.", 0ah
    response_yes_len equ $ - response_yes
    response_no db "Number is not prime.", 0ah
    response_no_len equ $ - response_no

