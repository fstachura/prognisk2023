global minmax
; esp - ret
; esp+4 - minmax pointer
; esp+8 - N
; esp+12+A - ath number
minmax:
    ; curent element
    push ebx
    ; current element address
    mov ecx, [esp+12]
    ; max
    mov edx, [esp+4*ecx+12]
    ; min
    mov eax, edx

l:
    mov ebx, [esp+4*ecx+12]

    cmp eax, ebx
    jle a
    mov eax, ebx

a:
    cmp ebx, edx
    jle n
    mov edx, ebx

n:
    dec ecx
    jnz l

    mov ecx, [esp+8]
    mov [ecx], eax
    mov [ecx+4], edx
    pop ebx
    ret
