section .text
global main

extern printf, scanf

main:
    enter 0, 0
    sub esp, 8

    lea eax, [ebp-4]
    push dword eax
    push dword scanf_str
    call scanf

    lea eax, [ebp-8]
    mov dword [esp+4], eax
    call scanf

    add esp, 2*4
    pop ebx
    pop eax
    xor edx, edx
    cdq
    idiv ebx

    push eax
    push printf_str
    call printf

    add esp, 2*4
    xor eax, eax
    leave
    ret

section .data
    scanf_str db '%d', 0, 0
    printf_str db '%d', 0ah, 0
