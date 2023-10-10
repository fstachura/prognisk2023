read_input:
    ; rax - length of read text
    ; rsi - text adress
    ; rdx - text length
    mov rax, 0
    mov rdi, 0
    syscall
    ret


write_output:
    ; rax - length of written text
    ; rsi - text adress
    ; rdx - text length
    mov rax, 1
    mov rdi, 1
    syscall
    ret


exit:
    mov rax, 60
    mov rdi, 0
    syscall


convert_to_int:
    ; (out) r9 - result
    ; rcx - text length
    ; rbx - text
    mov r8, 1
    mov r9, 0
    add rbx, rcx
    dec rbx
convert_to_int.loop:
    mov al, [rbx]
    cmp al, '-'
    je convert_to_int.exit

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
convert_to_int.exit:
    ; if last char was -, negate rax
    cmp al, '-'
    jne convert_to_int.ret
    neg r9

    mov rax, r9
convert_to_int.ret:
    ret


int_to_str:
    ; (out) rax - length of the number
    ; (in) rax - number to convert
    ; rbx - result buffer
    ; rcx - buffer length 
    mov r9, rcx     ; used to calculate length of the number
    add rbx, rcx    ; address of first digit
    mov rsi, 10

    ; check sign, negate and save sign if number is negative
    cmp rax, 0
    mov r8, 0
    jge int_to_str.loop
    neg rax
    mov r8, 1
int_to_str.loop:
    ; buffer is filled from the end - decrease buffer address to find 
    ; address of the next digit
    dec rbx
    dec rcx
    cmp rcx, 0
    jl int_to_str.exit

    ; extract least significant digit into rdx
    xor rdx, rdx
    div rsi

    ; convert least significant digit to ascii, write into bufffer
    add dl, '0'
    mov [rbx], dl

    ; if floor(rax/rsi) = 0, exit
    cmp rax, 0
    jz int_to_str.exit

    jmp int_to_str.loop
int_to_str.exit:
    ; calculate starting address
    sub r9, rcx
    mov rax, r9

    ; if there is still space in the buffer, and sign bit is 1
    cmp rcx, 0
    jle int_to_str.ret
    cmp r8, 0
    je int_to_str.ret

    ; then write minus into the buffer and recalculate start address
    mov byte [rbx-1], '-'
    dec rcx
    inc rax

int_to_str.ret:
    ret

