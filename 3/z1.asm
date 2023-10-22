section .text
global _start

%include "../common.asm"

_start:
    ; save current stack pointer as the beginning of the stack
    push rbp
    mov rbp, rsp

read_loop:
    ; read number to input
    mov rsi, input
    mov rdx, input_len
    call read_input

    ; skip newline
    sub rax, 1
    
    ; convert read number to int
    mov rbx, input
    mov rcx, rax
    call convert_to_int

    ; if number is zero, end loop
    cmp r9, 0
    je end_read_loop

    ; else push number, continue
    push r9
    jmp read_loop

end_read_loop:
    ; read divisor to input
    mov rsi, input
    mov rdx, input_len
    call read_input

    ; skip newline
    sub rax, 1
    
    ; convert divisor to int
    mov rbx, input
    mov rcx, rax
    call convert_to_int

    ; save divisor in rcx
    mov rcx, r9

    ; init count loop rbx - number of numbers divisible by r9
    mov rbx, 0

count_loop:
    ; if stack is empty, exit loop
    cmp rsp, rbp
    je end_count_loop

    ; pop number
    pop rax  

    ; div by ecx (div rax, mod rdx)
    mov rdx, 0
    div rcx
    cmp rdx, 0
    jne count_loop

    ; new number divisible by r9 - inc rbx
    inc rbx

    ; continue
    jmp count_loop

end_count_loop:
    ; recover stack frame
    mov rsp, rbp
    pop rbp

    ; convert number to string
    mov rax, rbx
    mov rbx, input
    mov rcx, input_len
    call int_to_str

    ; write to output 
    mov rsi, rax
    mov rdx, rcx
    inc rdx
    ; add newline
    mov byte [rsi+rdx], 0ah
    call write_output

    jmp exit

section .data
    input times 22 db 0
    input_len equ $ - input
    newline db 0ah

