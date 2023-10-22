read_input:
    ; rax - length of read text
    ; rsi - text adress
    ; rdx - text length
    mov rax, 0
    mov rdi, 0
    syscall
    ret


write_output:
    ; (out) rax - length of written text
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
    ; (out) r8 - number of bytes read
    ; rbx - text
    ; rcx - text length
    mov r10, rcx
    ; current digit position (multiplied by 10 each time)
    mov r8, 1
    mov r9, 0
    mov rax, 0
    add rbx, rcx
    dec rbx

convert_to_int.loop:
    ; get first byte
    mov al, [rbx]
    ; check if char is minus, it means that we are at the beginning of the number. exit
    cmp al, '-'
    je convert_to_int.exit_neg

    ; check if character is in ascii digit range
    cmp al, '0'
    jl convert_to_int.exit
    cmp al, '9'
    jg convert_to_int.exit

    ; substract 0 to get binary digit
    sub al, '0'

    ; multiply digit by r8 (digit position)
    mov rdx, rax
    imul rdx, r8
    add r9, rdx

    ; update r8 (multiply by 10)
    imul r8, 10 

    ; sub rbx to get next digit address
    sub rbx, 1
    ; sub rcx to update how many chars are left in the buffer
    sub rcx, 1
    ; check if rcx >= 0, if not, we are at the end of the buffer
    cmp rcx, 0
    jge convert_to_int.loop

convert_to_int.exit_neg:
    ; if last char before exit was -, negate rax
    cmp al, '-'
    jne convert_to_int.ret
    neg r9

convert_to_int.exit:
    ; save converted number in rax too
    mov rax, r9
    sub r10, rcx

convert_to_int.ret:
    ret


int_to_str:
    ; (in) rax - number to convert
    ; (in) rbx - result buffer
    ; (in) rcx - buffer length 
    ; (out) rax - pointer to start of the number
    ; (out) rcx - number length
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

    ; calculate result address - rbx = pointer to the end of the buffer
    add rbx, r9
    ; rbx = pointer to start of the number
    sub rbx, rax
    ; save number length in rcx
    mov rcx, rax
    ; rax = pointer to start of the number
    mov rax, rbx

int_to_str.ret:
    ret

