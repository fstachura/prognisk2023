global diff

diff:
    ; rdi - out
    ; rsi - wiersz
    ; rdx - n

    mov r9, rdx
    mov rcx, 0

    ; if n already too small for xmm registers, skip the xmm loop
    cmp rdx, 16
    jle .handle_rest
    
    ; rdx--, rdx = (rdx/16)*16
    sub rdx, 1
    shr rdx, 4
    shl rdx, 4

.loop: 
    movdqu xmm0, [rsi+rcx+1]
    movdqu xmm1, [rsi+rcx]
    psubb xmm0, xmm1
    movdqu [rdi+rcx], xmm0

    add rcx, 16
    cmp rcx, rdx
    jge .handle_rest
    jmp .loop

.handle_rest:
.rest_loop:
    cmp rcx, r9
    jge .ret

    mov rax, [rsi+rcx+1]
    sub rax, [rsi+rcx]
    mov [rdi+rcx], rax

    add rcx, 1
    jmp .rest_loop

.ret:
    ret
    
