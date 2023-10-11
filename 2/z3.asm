section .text
global _start

%include "common.asm"

factorize:
    ; rdi - number
    ; rsi - output buffer
    ; rbx - output buffer length

    ; rcx = currently checked factor
    mov rcx, 2
    ; edge case - if number = 2, return
    cmp rcx, rdi
    je factorize.ret
    ; if number is negative, negate it
    cmp rdi, 0
    jge factorize.loop
    neg rdi
factorize.loop:
    ; dividie
    mov rdx, 0
    mov rax, rdi
    div rcx
    cmp rdx, 0
    jne factorize.loop_check

    ; save regs before calling int_to_str
    push rcx
    push rdi
    push rsi
    push rbx
    push rdi
    ; rcx = ouptut buffer length
    mov rcx, rbx
    ; rbx = output buffer
    mov rbx, rsi
    ; convert int to str
    call int_to_str
    
    ; rdx = text length
    mov rdx, rax
    ; add 1 for newline (it's after the buffer)
    add rdx, 1
    ; find number start after int_to_str
    mov rsi, number
    add rsi, number_len
    sub rsi, rax
    ; write numbre
    call write_output

    ; restore registers
    pop rdi
    pop rbx
    pop rsi
    pop rdi
    pop rcx

factorize.loop_check:
    ; update next factor checked
    inc rcx
    ; if current factor is greater than number, exit
    cmp rcx, rdi
    jge factorize.ret
    jmp factorize.loop
factorize.ret:
    ret


_start: 
    ; read numbery
    mov rsi, number
    mov rdx, number_len
    call read_input 

    ; convert it to int
    mov rbx, number
    mov rcx, rax
    sub rcx, 1
    call convert_to_int

    ; factorize
    mov rdi, r9
    mov rsi, number
    mov rbx, number_len
    call factorize

    jmp exit
    
section .data
    number times 22 db 'x'
    number_len equ $ - number
    space_and_newline db 0ah
    total_len equ $ - space_and_newline

