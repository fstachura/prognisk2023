global suma

suma:
    ; rdi - n
    ; rsi - tab
    ; rax - result
    mov rax, 0
    add rdi, 1

.loop: add rax, [rsi+4*rdi-4]
    sub rdi, 1
    jg .loop

    ret
