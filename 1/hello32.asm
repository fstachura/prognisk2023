section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, text
    mov edx, length
    int 80h

    mov eax, 1
    int 80h

section data
    text db "Czesc", 0ah
    length equ $ - text
