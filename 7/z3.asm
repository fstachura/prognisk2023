global iloczyn
iloczyn:
    ; RDI, RSI, RDX, RCX, R8, R9
    ; rdi - n
    mov rax, 1
    cmp rdi, 0
    jle .ret

    imul rax, rsi
    sub rdi, 1
    cmp rdi, 0
    jle .ret

    imul rax, rdx
    sub rdi, 1
    cmp rdi, 0
    jle .ret

    imul rax, rcx
    sub rdi, 1
    cmp rdi, 0
    jle .ret

    imul rax, r8
    sub rdi, 1
    cmp rdi, 0
    jle .ret

    imul rax, r9
    sub rdi, 1
    cmp rdi, 0
    jle .ret

    pop rcx
.loop:
    pop rdx
    imul rax, rdx
    sub rdi, 1
    cmp rdi, 0
    jg .loop

    push rcx
.ret:
    ret

