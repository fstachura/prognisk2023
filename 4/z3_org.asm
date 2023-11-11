global sortuj
sortuj:
    mov dword eax, [esp+4]
    mov dword ecx, [esp+8]
    mov dword edx, [esp+12]
    mov dword eax, [eax]
    mov dword ecx, [ecx]
    mov dword edx, [edx]
    cmp edx, eax
    jle a
    xchg edx, eax
a:
    cmp ecx, eax
    jle b
    xchg ecx, eax
b:
    cmp edx, ecx
    jle c
    xchg edx, ecx
c:
    push ebx
    mov dword ebx, [esp+8]
    mov dword [ebx], eax
    mov dword ebx, [esp+12]
    mov dword [ebx], ecx
    mov dword ebx, [esp+16]
    mov dword [ebx], edx
    pop ebx
    ret
