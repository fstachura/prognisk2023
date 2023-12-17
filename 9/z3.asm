global scaleSSE

; OUT(i,j) = (IN(2*i,2*j) + IN(2*i +1,2*j) + IN(2*i,2*j + 1) + IN(2*i + 1,2*j + 1))/4

scaleSSE:
    ; rdi - result[i] (row)
    ; rsi - data[2*i] (row)
    ; rdx - N

    ; j
    mov rcx, 0
    ; N /= 2
    shr rdx, 1

.loop:
    cmp rcx, rdx
    jge .ret

    mov rax, rcx
    shl rax, 1
    ; load 2*i; 2*j, 2*j+1
    movlps xmm0, [rsi+4*rax]
    add rax, rdx
    add rax, rdx
    ; load 2*i+1; 2*j, 2*j+1
    movhps xmm0, [rsi+4*rax]

    haddps xmm0, xmm0
    haddps xmm0, xmm0

    divss xmm0, [four]

    movss [rdi+4*rcx], xmm0

    add rcx, 1
    jmp .loop

.ret:
    ret
     

section .data
    four dd 4.0

