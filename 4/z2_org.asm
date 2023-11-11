BITS 32
section .text
global iloczyn
iloczyn:
    enter 0,0

    push ebx
    push esi
    push edi

    ; ebx - array address
    mov ebx, [ebp+12]
    ; edi - n
    mov edi, [ebp+8]
    ; eax - result
    mov eax, 1

iloczyn.loop:
    cmp edi, 0
    je iloczyn.exit

    mov esi, [ebx]
    mov edx, 0
    imul esi

    add ebx, 4
    dec edi
    jmp iloczyn.loop

iloczyn.exit:
    pop edi
    pop esi
    pop ebx

    leave
    ret
