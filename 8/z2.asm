global _Z6kopiujPjS_j, _Z5zerujPjj

_Z6kopiujPjS_j:
    ; rdi - cel
    ; rsi - zrodlo
    ; rdx - n
    cld
    mov rcx, rdx
    rep movsd
    ret

_Z5zerujPjj:
    ; rdi - cel
    ; rsi - n
    cld
    mov rax, 0
    mov rcx, rsi
    rep stosd
    ret
