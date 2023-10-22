section .text
global _start

%include "../common.asm"

find_max_int:
    ; stack: num of elements, pointer to first element
    ; (out) rax - max number in array
    ; assumption: num of elements is greater than 0

    ; pop number of elements into rcx
    mov rcx, [rsp+8]
    ; pop array address into rbx
    mov rbx, [rsp+16]
    ; init rax with the first element
    mov rax, [rbx]

find_max_int.loop:
    ; if rcx is zero or less, exit
    cmp rcx, 0
    jle find_max_int.exit

    ; get element
    mov r9, [rbx]
    ; if element is greater than rax, continue
    cmp rax, r9
    jge find_max_int.loop_end

    ; else update rax
    mov rax, r9

find_max_int.loop_end:
    ; update rcx, update rbx, loop
    dec rcx
    add rbx, 8
    jmp find_max_int.loop

find_max_int.exit:
    pop r9
    sub rsp, 16
    push r9
    ret


_start:
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

    ; init array size counter
    mov rcx, r9

read_loop:
    ; if rcx <= 0, end loop
    cmp rcx, 0
    jle end_read_loop

    ; save rcx (current counter), r9 (original content)
    push rcx
    push r9

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

    ; restore r9, rcx
    mov rax, r9
    pop r9
    pop rcx

    ; push number, update counter, loop
    push rax
    dec rcx
    jmp read_loop

end_read_loop:
    ; push array address (rsp)
    push rsp
    ; push array length (r9)
    push r9
    ; find greatest number
    call find_max_int

    ; convert number to string
    mov rbx, input
    mov rcx, input_len
    call int_to_str

    ; write number
    mov rsi, rax
    mov rdx, rcx
    mov byte [rsi+rdx], 0ah
    inc rdx
    call write_output 

    jmp exit

section .data
    input times 22 db 0
    input_len equ $ - input

