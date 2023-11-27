global podatek, wypisz
extern printf

podatek:
    ; edi - id
    ; edih - obrot
    ; xmm0 - podatekNaliczony, stawkaPodatku
    ; rsi - nextID (pointer?)
    ; (obrot-podatekNaliczony)*stawkaPodatku
    mov rax, rdi
    shr rax, 32
    movd xmm1, eax
    pshufd xmm2, xmm0, 1
    ; xmm0 - podatekNaliczony    
    ; xmm1 - obrot
    ; xmm2 - stawkaPodatku
    movsd xmm3, xmm0
    movsd xmm0, xmm1
    subps xmm0, xmm3
    mulps xmm0, xmm2
    ret

wypisz:
    sub rsp, 8

    ; rdi - struct address
    mov rax, rdi

    ; load id, obrot
    mov rdi, [rax]
    ; load podatekNaliczony, stawkaPodatku
    movups xmm0, [rax+8]
    ; skip nextID because podatek does not care 

    ; calculate podatek
    push rax
    call podatek
    pop rax

    ; convert podatek to double (idk why its passed by xmm1 instead of the upper half of xmm0)
    cvtss2sd xmm1, xmm0
    ; move podatek result to upper part of xmm0
    movlhps xmm0, xmm0
    ; load id
    mov rsi, [rax]
    ; load obrot
    cvtss2sd xmm0, [rax+4]

    ; number of floats
    mov rax, 2
    ; load string
    mov rdi, wypisz_printf

    call printf
    add rsp, 8
    ret

section data
    wypisz_printf db "Faktura %d : obrot %f podatek %f", 0ah

