global gradientSSE

gradientSSE:
    ; rdi - grad
    ; rsi - data
    ; rdx - N
    ; xmm0 - scale

    mov rax, 0

    ; prepare mask scale mask
    shufps xmm0, xmm0, 0x00
    movaps xmm3, xmm0

    shl rdx, 2

.loop:
    cmp rax, rdx
    jge .ret

    ; data[i+1]
    movups xmm0, [rsi+rax+4]
    ; data[i-1]
    movups xmm1, [rsi+rax-4]

    ; data[i+1]-data[i-1]
    subps xmm0, xmm1
    ; (data[i+1]-data[i-1])^2
    mulps xmm0, xmm0

    mov r9, rax
    add r9, rdx
    ; data[i+N]
    movups xmm1, [rsi+r9]

    mov r9, rax
    sub r9, rdx
    ; data[i-N]
    movups xmm2, [rsi+r9]

    ; data[i+N]-data[i-N]
    subps xmm1, xmm2
    ; (data[i+N]-data[i-N])^2
    mulps xmm1, xmm1

    ; (data[i+1]-data[i-1])^2+(data[i+N]-data[i-N])^2
    addps xmm0, xmm1
    ; sqrt( (data[i+1]-data[i-1])^2+(data[i+N]-data[i-N])^2 )
    sqrtps xmm0, xmm0
    
    ; scale*sqrt( (data[i+1]-data[i-1])^2+(data[i+N]-data[i-N])^2 )
    mulps xmm0, xmm3

    ; save 
    movups [rdi+rax], xmm0

    add rax, 16
    jmp .loop

.ret:
    ret
     
