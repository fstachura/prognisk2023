global wartosc
wartosc:
    ; (a*x+b)^n
    ; xmm0 - a
    ; xmm1 - b
    ; xmm2 - x
    ; rdi - n 
    mulsd xmm0, xmm2
    addsd xmm0, xmm1
    movsd xmm1, xmm0

    mov rax, 0
    cmp edi, 0
    jge .loop
    neg edi
    mov rax, 1

.loop:
    cmp rdi, 1
    jle .endloop

    mulsd xmm0, xmm1
    sub rdi, 1
    jmp .loop

.endloop:
    cmp rax, 0
    je .ret
    movsd xmm1, [mask]
    divsd xmm1, xmm0
    movsd xmm0, xmm1

.ret:
    ret
    
section data
    mask dq 1.0

